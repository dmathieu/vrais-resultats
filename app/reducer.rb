require "reducer/base"
require "reducer/departementales"
require "reducer/europeennes"
require "reducer/legislatives"
require "reducer/municipales"
require "reducer/presidentielles"
require "reducer/regionales"

module VR
  module Reducer
    def self.find(config, mapper)
      "VR::Reducer::#{config[:reducer].camelize}::Annee#{config[:annee]}".constantize.new(config, mapper)
    end
  end
end
