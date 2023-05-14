# frozen_string_literal: true

RSpec.describe Rupis do
  let(:server) { Client.new }

  it "can initialize" do
    expect(server).not_to be nil
    resp =
      server.execute("initialize", { processId: Process.pid, capabilities: {} })
    expect(resp).to eq({ capabilities: {} })
  end
end
