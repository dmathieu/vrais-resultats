module VR
  module Indexer
    class Base
      def initialize(config, mapper)
        @config = config
        @mapper = mapper
      end

      private

      def event
        @event ||= Event.find_or_create_by!(name: @config[:name])
      end
    end
  end
end
