# frozen_string_literal: true

require "syntax_tree"

module Ruuse
  class InternalServer
    def initialize
      # TODO
    end

    def parse(text)
      parsed = SyntaxTree.parse(text)
      parsed.to_json
    end
  end
end
