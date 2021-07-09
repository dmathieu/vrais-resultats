module VR
  module Reducer
    class Base
      def initialize(config, mapper)
        @config = config
        @mapper = mapper
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
