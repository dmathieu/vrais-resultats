module VR
  module Reducer
    class Legislatives::Annee2017 < Legislatives
      private

      def keymap
        [
          {key: :inscrits, index: 6, default: 0},
          {key: :abstentions, index: 7, default: 0},
          {key: :votants, index: 9, default: 0},
          {key: :blancs, index: 11, default: 0},
          {key: :nuls, index: 14, default: 0},
          {key: :exprimes, index: 17, default: 0}
        ]
      end

      def skip_row_if(i, row)
        return true if i < 4
      end

      def row_name(row)
        "#{row[3]} #{row[1]}"
      end

      def row_path(row)
        row[1].parameterize + "/" + row[2].to_s
      end

      def candidats_split(entry)
        entry.drop(20).each_slice(8).each do |c|
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
