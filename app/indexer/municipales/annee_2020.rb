module VR
  module Indexer
    module Municipales
      class Annee2020 < Base
        set_keymap({
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
