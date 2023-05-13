# frozen_string_literal: true

require "ruuse"
require "open3"
require "json"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

class Client
  def initialize
    @server = Open3.popen3("ruby -Ilib exe/ruuse")
    @id = 0
  end

  def dispatch(method, payload)
    payload_json = {
      jsonrpc: "2.0",
      id: @id += 1,
      method: method,
      params: payload
    }.to_json

    @server[0].write(
      ["Content-Length: #{payload_json.length}", "", payload_json].join("\r\n")
    )
    @server[0].flush
  end

  def execute(method, payload)
    dispatch(method, payload)
    r = receive
    raise "Invalid response" unless r[:id] == @id
    raise r[:error] if r[:error]

    r[:result]
  end

  def receive
    header = @server[1].readline("\r\n\r\n")
    content_length = header.match(/Content-Length: (\d+)/)[1].to_i
    content = @server[1].read(content_length)
    JSON.parse(content, symbolize_names: true)
  end
end
