# frozen_string_literal: true

module VR
  module Reducer
    class Municipales
      class Annee2020 < Municipales
        private

        def parse_data
          super.select { |e| e[:resultats].any? { |r| !r.nil? && r[:inscrits] >= 1000 } }
        end

        def keymap
          [
            { key: :inscrits, index: 5, default: 0 },
            { key: :abstentions, index: 6, default: 0 },
            { key: :votants, index: 8, default: 0 },
            { key: :blancs, index: 10, default: 0 },
            { key: :nuls, index: 13, default: 0 },
            { key: :exprimes, index: 16, default: 0 }
          ]
        end

        def skip?(i, _row)
          i < 1
        end

        def row_name(row)
          row[3]
        end

        def row_path(row)
          "#{row[1].parameterize}/#{row_name(row).parameterize}"
        end

        def candidats_split(entry)
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

          candidats.each do |c|
            liste = c[5] || ''
            while c[6].is_a?(String)
              liste += " #{c[6]}"
              c.delete_at(6)
            end

            yield({
              nom: [c[3], c[4]].compact.join(' '),
              voix: c[6],
              liste:
            })
          end
        end
      end
    end
  end
end
