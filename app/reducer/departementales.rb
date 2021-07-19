require "reducer/departementales/annee_2021"

module VR
  module Reducer
    module Departementales
      def self.new(config, mapper)
        const_get("Annee#{config[:annee]}").new(config, mapper)
      end
    end
  end
end
