# frozen_string_literal: true

require_relative "rupis/version"
require_relative "rupis/server"
require_relative "rupis/rupis"

module Rupis
  class Error < StandardError; end

  def self.start
    @server = Rupis::InternalServer.new
    exit unless _start(@server)
  end
end
