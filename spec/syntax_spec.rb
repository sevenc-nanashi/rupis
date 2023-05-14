# frozen_string_literal: true

require "tempfile"
require "uri"

RSpec.describe Rupis do
  include_context "server"

  it "can open file" do
    tempfile = Tempfile.new
    tempfile.write("puts 'hello world'")
    path = tempfile.path
    tempfile.close
    server.notify(
      "textDocument/didOpen",
      {
        textDocument: {
          uri: URI::File.build([nil, path]).to_s,
          languageId: "ruby",
          version: 1,
          text: "puts 'hello world'"
        }
      }
    )
  end
end
