# frozen_string_literal: true

require_relative "ruuse/version"
require_relative "ruuse/server"
require_relative "ruuse/ruuse"

module Ruuse
  class Error < StandardError; end

  def self.start
    @server = Ruuse::InternalServer.new
    exit unless _start(@server)
  end
end
