require "reducer/municipales/annee_2020"

module VR
  module Reducer
    module Municipales
      def self.new(config, mapper)
        const_get("Annee#{config[:annee]}").new(config, mapper)
      end
    end
  end
end
