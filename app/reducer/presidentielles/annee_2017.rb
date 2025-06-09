# frozen_string_literal: true

module VR
  module Reducer
    class Presidentielles
      class Annee2017 < Presidentielles
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

        def skip?(i, _row)
          i <= 3
        end

        def row_name(_row)
          ''
        end

        def row_path(_row)
          ''
        end

        def candidats_split(entry)
          entry.drop(18).each_slice(7).each do |c|
            yield({
              nom: [c[2], c[3]].compact.join(' '),
              voix: c[4],
              liste: ''
            })
          end
        end
      end
    end
  end
end
