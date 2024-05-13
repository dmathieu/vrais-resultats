# frozen_string_literal: true

module VR
  module Reducer
    class Departementales
      class Annee2021 < Departementales
        private

        def keymap
          [
            { key: :inscrits, index: 4, default: 0 },
            { key: :abstentions, index: 5, default: 0 },
            { key: :votants, index: 7, default: 0 },
            { key: :blancs, index: 9, default: 0 },
            { key: :nuls, index: 12, default: 0 },
            { key: :exprimes, index: 15, default: 0 }
          ]
        end

        def skip_row_if(i, _row)
          true if i < 1
        end

        def row_name(row)
          "Circoncription #{row[2]} #{row[1]}"
        end

        def row_path(row)
          "#{row[1].parameterize}/#{row[2]}"
        end

        def default_hash(_entry, name)
          h = {
            candidats: [],
            name:
          }

          KEYMAP.each do |k|
            h[k[:key]] = k[:default]
          end

          h
        end

        def candidats_split(entry)
          entry.drop(18).each_slice(7).each do |c|
            yield({
              nom: c[1],
              voix: c[3],
              liste: ''
            })
          end
        end
      end
    end
  end
end
