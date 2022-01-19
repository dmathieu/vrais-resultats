module VR
  module Reducer
    class Departementales::Annee2021 < Departementales
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
        return true if i < 1
      end

      def row_name(row)
        "Circoncription #{row[2]} #{row[1]}"
      end

      def row_path(row)
        row[1].parameterize + "/" + row[2].to_s
      end

      def default_hash(entry, name)
        h = {
          candidats: [],
          name:
        }

        KEYMAP.each do |k|
          h[k[:key]] = k[:default]
        end

        h
      end

      def update_candidats(data, entry)
        VR.tracer.in_span("reducer.update_candidats") do |span|
          entry.drop(18).each_slice(7) do |c|
            nom = c[1]
            liste = ""
            voix = c[3]
            next if nom.nil? || voix.nil?

            existing = data.find_index { |s| s[:nom] == nom }
            if existing
              data[existing][:voix] += voix
              next
            end

            data << {
              nom:,
              liste:,
              voix:
            }
          end

          data
        end
      end
    end
  end
end
