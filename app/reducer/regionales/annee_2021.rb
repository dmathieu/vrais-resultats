module VR
  module Reducer
    class Regionales::Annee2021 < Regionales
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
        return true if row.compact.empty?
        name = row_name(row)
        return true if name == false || name.nil?
      end

      def row_name(row)
        row[1]
      end

      def row_path(row)
        row_name(row).parameterize
      end

      def update_candidats(data, entry)
        VR.tracer.in_span("reducer.update_candidats") do |span|
          entry.drop(16).each_slice(9) do |c|
            next if c.compact.empty?
            nom = c[4]
            liste = c[3]
            voix = c[5]
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
