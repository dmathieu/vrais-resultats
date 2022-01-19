module VR
  module Reducer
    class Municipales::Annee2020 < Municipales
      private

      def parse_data
        super.select { |e| e[:resultats].any? { |r| !r.nil? && r[:inscrits] >= 1000 } }
      end

      private

      def keymap
        [
          {key: :inscrits, index: 5, default: 0},
          {key: :abstentions, index: 6, default: 0},
          {key: :votants, index: 8, default: 0},
          {key: :blancs, index: 10, default: 0},
          {key: :nuls, index: 13, default: 0},
          {key: :exprimes, index: 16, default: 0}
        ]
      end

      def skip_row_if(i, row)
        i == 0
      end

      def row_name(row)
        row[3]
      end

      def row_path(row)
        row[1].parameterize + "/" + row_name(row).parameterize
      end

      def update_candidats(data, entry)
        VR.tracer.in_span("reducer.update_candidats") do |span|
          candidats = []

          current = 0
          cdata = entry.dup.drop(19)
          candidats[0] = [cdata[0]]
          cdata.each_cons(3) do |prev, cur, nex|
            if prev.is_a?(Numeric) && cur.is_a?(Numeric) && nex.is_a?(String)
              current += 1
              candidats[current] = []
            end
            candidats[current] << cur
          end
          candidats[current] << data.last

          candidats.each do |c|
            nom = [c[3], c[4]].compact.join(" ")
            liste = c[5] || ""
            while c[6].is_a?(String)
              liste += " " + c[6]
              c.delete_at(6)
            end
            voix = c[6]

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
