require "reducer/presidentielles/annee_2017"

module VR
  module Reducer
    module Presidentielles
      def self.new(config, content)
        const_get("Annee#{config[:annee]}").new(config, content)
      end
    end
  end
end
