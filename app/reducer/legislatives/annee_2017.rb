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

      def update_candidats(data, entry)
        VR.tracer.in_span("reducer.update_candidats") do |span|
          entry.drop(20).each_slice(8) do |c|
            nom = [c[2], c[3]].compact.join(" ")
            voix = c[5]
            next if nom.nil? || voix.nil?

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
end
