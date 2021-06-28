module Elections
  module Renderer
    class Municipales
      KEYMAP = [
        {key: "ville", index: 3}
      ]

      def initialize(data)
        @data = data
      end

      def content
        @content ||= parse_data
      end

      private

      def parse_data
        data = {}

        @data.each_with_index do |e,i|
          next if i == 0
        end

        data
      end
    end
  end
end
