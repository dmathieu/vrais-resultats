# frozen_string_literal: true

module VR
  module Reducer
    module Regionales
      class Annee2021 < Regionales
        private

        def keymap
          [
            { key: :inscrits, index: 2, default: 0 },
            { key: :abstentions, index: 3, default: 0 },
            { key: :votants, index: 5, default: 0 },
            { key: :blancs, index: 7, default: 0 },
            { key: :nuls, index: 10, default: 0 },
            { key: :exprimes, index: 13, default: 0 }
          ]
        end

        def skip_row_if(i, row)
          return true if i < 1
          return true if row.compact.empty?

          name = row_name(row)
          true if name == false || name.nil?
        end

        def row_name(row)
          row[1]
        end

        def row_path(row)
          row_name(row).parameterize
        end

        def candidats_split(entry)
          entry.drop(16).each_slice(9).each do |c|
            yield({
              nom: c[4],
              voix: c[5],
              liste: c[3]
            })
          end
        end
      end
    end
  end
end
