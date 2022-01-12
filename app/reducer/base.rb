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
          annee: @config[:annee],
          data:
        }
      end

      private

      def data
        @data ||= parse_data
      end

      def parse_data
        VR.tracer.in_span("reducer.parse_data") do |span|
          data = {}
          @mapper.each_with_index do |file, index|
            data = parse_file(file, index, data)
          end
          data.values
        end
      end

      def parse_file(file, index, data)
        raise NotImplementedError
      end
    end
  end
end
