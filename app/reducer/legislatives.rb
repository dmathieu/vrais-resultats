require "reducer/legislatives/annee_2017"

module VR
  module Reducer
    module Legislatives
      def self.new(config, mapper)
        const_get("Annee#{config[:annee]}").new(config, mapper)
      end
    end
  end
end
