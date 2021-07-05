require "reducer/base"
require "reducer/municipales"
require "reducer/presidentielles"

module VR
  module Reducer
    LIST = {
      municipales: Reducer::Municipales
    }

    def self.new(config, content)
      const_get(config[:reducer].camelize).new(config, content)
    end
  end
end
