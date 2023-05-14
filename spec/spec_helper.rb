# frozen_string_literal: true

require "rupis"
require "open3"
require "json"
require "timeout"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

RSpec.shared_context "server" do
  let(:server) do
    c = Client.new
    resp = c.request("initialize", { processId: Process.pid, capabilities: {} })
    expect(resp).to eq({ capabilities: {} })
    c.notify("initialized", {})
    c
  end
end

class Client
  def initialize
    @server = Open3.popen2("ruby -Ilib exe/rupis")
    @id = 0
  end

  def write(payload)
    payload_json = payload.to_json
    payload_str = [
      "Content-Length: #{payload_json.length}",
      "",
      payload_json
    ].join("\r\n")

    @server[0].write(payload_str)
    @server[0].flush
  end

  def notify(method, payload)
    write({ jsonrpc: "2.0", method: method, params: payload })
  end

  def request(method, payload)
    write({ jsonrpc: "2.0", id: @id += 1, method: method, params: payload })

    r = receive
    raise "Response does not match" unless r[:id] == @id

    r[:result]
  end

  def receive
    loop do
      Timeout.timeout(1) do
        header = @server[1].readline("\r\n\r\n")
        content_length = header.match(/Content-Length: (\d+)/)[1].to_i
        content = @server[1].read(content_length)
        r = JSON.parse(content, symbolize_names: true)
        if r[:error]
          raise "Server returned error: #{r[:error]}"
        elsif r[:method] == "window/logMessage"
          warn r[:params][:message]
        else
          return r
        end
      end
    end
  end
end
