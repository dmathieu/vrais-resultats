require "reducer/municipales/annee_2020"

module VR
  module Reducer
    module Municipales
      def self.new(config, content)
        const_get("Annee#{config[:annee]}").new(config, content)
      end
    end
  end
end
