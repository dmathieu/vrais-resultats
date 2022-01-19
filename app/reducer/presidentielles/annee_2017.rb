module VR
  module Reducer
    class Presidentielles::Annee2017 < Presidentielles
      private

      def keymap
        [
          {key: :inscrits, index: 4, default: 0},
          {key: :abstentions, index: 5, default: 0},
          {key: :votants, index: 7, default: 0},
          {key: :blancs, index: 9, default: 0},
          {key: :nuls, index: 12, default: 0},
          {key: :exprimes, index: 15, default: 0}
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

      def update_candidats(data, entry)
        entry.drop(18).each_slice(7) do |c|
          nom = c[2] + " " + c[3]
          voix = c[4]

          existing = data.find_index { |s| s[:nom] == nom }
          if existing
            data[existing][:voix] += voix
            next
          end

          data << {
            nom:,
            liste: "",
            voix:
          }
        end

        data
      end
    end
  end
end
