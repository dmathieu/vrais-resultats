module VR
  module Reducer
    class Legislatives::Annee2022 < Legislatives
      private

      def keymap
        [
          {key: :inscrits, index: 7, default: 0},
          {key: :abstentions, index: 8, default: 0},
          {key: :votants, index: 10, default: 0},
          {key: :blancs, index: 12, default: 0},
          {key: :nuls, index: 15, default: 0},
          {key: :exprimes, index: 18, default: 0}
        ]
      end

      def skip_row_if(i, row)
        return true if i < 1
      end

      def row_name(row)
        "#{row[3]} #{row[1]}"
      end

      def row_path(row)
        row[1].parameterize + "/" + row[2].to_s
      end

      def candidats_split(entry)
        entry.drop(21).each_slice(8).each do |c|
          yield({
            nom: [c[2], c[3]].compact.join(" "),
            voix: c[5],
            liste: ""
          })
        end
      end
    end
  end
end
