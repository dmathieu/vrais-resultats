# frozen_string_literal: true

module VR
  module Reducer
    class Legislatives
      class Annee2024 < Legislatives
        private

        def keymap
          [
            { key: :inscrits, index: 4, default: 0 },
            { key: :abstentions, index: 7, default: 0 },
            { key: :votants, index: 5, default: 0 },
            { key: :blancs, index: 12, default: 0 },
            { key: :nuls, index: 15, default: 0 },
            { key: :exprimes, index: 9, default: 0 }
          ]
        end

        def skip_row_if(index, _row)
          true if index < 1
        end

        def row_name(row)
          "#{row[3]} #{row[1]}"
        end

        def row_path(row)
          "#{row[1].parameterize}/#{row[2]}"
        end

        def candidats_split(entry)
          entry.drop(18).each_slice(9).each do |c|
            next if c.compact.empty?

            yield({
              nom: [c[2], c[3]].compact.join(' '),
              voix: c[5],
              liste: ''
            })
          end
        end
      end
    end
  end
end
