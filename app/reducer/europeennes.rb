require "reducer/europeennes/annee_2019"

module VR
  module Reducer
    module Europeennes
      def self.new(config, mapper)
        const_get("Annee#{config[:annee]}").new(config, mapper)
      end
    end
  end
end
