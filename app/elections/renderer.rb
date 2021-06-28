require 'elections/renderer/municipales'

module Elections
  module Renderer
    LIST = {
      "municipales": Elections::Renderer::Municipales,
    }

    def self.new(name, content)
      raise "unknown renderer #{name}" if !LIST.has_key?(name.to_sym)
      LIST[name.to_sym].new(content)
    end
  end
end
