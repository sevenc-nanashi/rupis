# frozen_string_literal: true

RSpec.describe Rupis do
  let(:server) { Client.new }

  it "can initialize" do
    expect(server).not_to be nil
    resp =
      server.request("initialize", { processId: Process.pid, capabilities: {} })
    expect(resp).to eq({ capabilities: {} })
    server.notify("initialized", {})
  end
end
