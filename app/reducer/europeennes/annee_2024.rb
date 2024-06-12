# frozen_string_literal: true

module VR
  module Reducer
    class Europeennes
      class Annee2024 < Europeennes
        private

        def keymap
          [
            { key: :inscrits, index: 2, default: 0 },
            { key: :abstentions, index: 5, default: 0 },
            { key: :votants, index: 3, default: 0 },
            { key: :blancs, index: 10, default: 0 },
            { key: :nuls, index: 13, default: 0 },
            { key: :exprimes, index: 7, default: 0 }
          ]
        end

        def skip_row_if(index, _row)
          index < 2
        end

        def row_name(_row)
          ''
        end

        def row_path(_row)
          ''
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
          entry.drop(16).each_slice(8).each do |c|
            yield({
              nom: c[2].titleize,
              voix: c[4],
              liste: c[3].titleize
            })
          end
        end
      end
    end
  end
end
