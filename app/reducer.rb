require "reducer/base"
require "reducer/departementales"
require "reducer/europeennes"
require "reducer/legislatives"
require "reducer/municipales"
require "reducer/presidentielles"

module VR
  module Reducer
    LIST = {
      municipales: Reducer::Municipales
    }

    def self.new(config, mapper)
      const_get(config[:reducer].camelize).new(config, mapper)
    end
  end
end
