module VR
  module Reducer
    class Base
      def initialize(config, data)
        @config = config
        @raw_data = data
      end

      def content
        @content ||= {
          name: @config[:name],
          data: data
        }
      end

      private

      def data
        raise NotImplementedError
      end
    end
  end
end
