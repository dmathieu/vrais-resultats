module VR
  module Indexer
    module Municipales
      class Annee2020 < Base
        skip 1

        valid_row?(lambda do |row|
          !row[3] == false &&
            !row[3].nil? &&
            !row.empty?
        end)

        keymap({
          area_name: {index: 3},
          area_path: lambda { |row| row[1].parameterize + "/" + row[3].parameterize },

          inscrits: {index: 5},
          abstentions: {index: 6},
          votants: {index: 8},
          blancs: {index: 10},
          nuls: {index: 13},
          exprimes: {index: 16}
        })
      end
    end
  end
end
