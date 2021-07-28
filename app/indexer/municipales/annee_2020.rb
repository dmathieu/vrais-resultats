module VR
  module Indexer
    module Municipales
      class Annee2020 < Base
        set_skip 1
        set_keymap({
          area_name: { index: 3 },
          area_path: lambda { |row| row[1].parameterize + "/" + row[3].parameterize},

          inscrits: { index: 5 },
          abstentions: { index: 6 },
          votants: { index: 8 },
          blancs: { index: 10 },
          nuls: { index: 13 },
          exprimes: { index: 16 },
        })

      end
    end
  end
end
