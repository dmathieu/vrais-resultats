module Elections
  module Renderer
    class Municipales
      MAINKEY = 3

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

          l = data[e[MAINKEY]] || {
            departement: e[0],

            inscrits: 0,
            abstentions: 0,
            votants: 0,
            blancs: 0,
            nuls: 0,
            exprimes: 0,

            candidats: [],
          }

          l[:inscrits] += e[5]
          l[:abstentions] += e[6]
          l[:votants] += e[8]
          l[:blancs] += e[10]
          l[:nuls] += e[13]
          l[:exprimes] += e[16]

          data[e[MAINKEY]] = l
        end

        data
      end
    end
  end
end
