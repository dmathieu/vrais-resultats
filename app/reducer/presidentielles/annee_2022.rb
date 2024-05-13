# frozen_string_literal: true

module VR
  module Reducer
    module Presidentielles
      class Annee2022 < Presidentielles
        private

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

        def skip_row_if(i, _row)
          i <= 1
        end

        def row_name(_row)
          ''
        end

        def row_path(_row)
          ''
        end

        def candidats_split(entry)
          entry.drop(20).each_slice(7).each do |c|
            yield({
              nom: [c[2], c[1]].compact.join(' '),
              voix: c[3],
              liste: ''
            })
          end
        end
      end
    end
  end
end
