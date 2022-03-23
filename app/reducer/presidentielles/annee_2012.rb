module VR
  module Reducer
    class Presidentielles::Annee2012 < Presidentielles
      private

      def keymap
        [
          {key: :inscrits, index: 3, default: 0},
          {key: :abstentions, fn: lambda { |r| r[3].to_i - r[4].to_i }, default: 0},
          {key: :votants, index: 4, default: 0},
          {key: :nuls, index: 6, default: 0},
          {key: :exprimes, index: 5, default: 0}
        ]
      end

      def skip_row_if(i, row)
        i <= 3
      end

      def row_name(row)
        ""
      end

      def row_path(row)
        ""
      end

      def header_row = 0

      def candidats_split(entry)
        @header.drop(7).each_with_index do |c, i|
          yield({
            nom: c,
            voix: entry[i + 7].to_i,
            liste: ""
          })
        end
      end
    end
  end
end
