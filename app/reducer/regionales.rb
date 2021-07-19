require "reducer/regionales/annee_2021"

module VR
  module Reducer
    module Regionales
      def self.new(config, mapper)
        const_get("Annee#{config[:annee]}").new(config, mapper)
      end
    end
  end
end
