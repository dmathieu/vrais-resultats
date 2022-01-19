module VR
  module Reducer
    class Europeennes::Annee2019 < Europeennes
      private

      def keymap
        [
          {key: :inscrits, index: 2, default: 0},
          {key: :abstentions, index: 3, default: 0},
          {key: :votants, index: 5, default: 0},
          {key: :blancs, index: 7, default: 0},
          {key: :nuls, index: 10, default: 0},
          {key: :exprimes, index: 13, default: 0}
        ]
      end

      def skip_row_if(i, row)
        return true if i < 1
      end

      def row_name(row)
        row[1]
      end

      def row_path(row)
        row_name(row).parameterize
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
          entry.drop(16).each_slice(7) do |c|
            nom = c[3]
            liste = c[2]
            voix = c[4]
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
