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

        candidats_splitter(lambda do |data|
          data = data.drop(19)
          candidats = []

          current = 0
          index = 0
          data.each do |e|
            next if index == 0 && e.nil?
            if index == 6 && e.is_a?(String)
              candidats[current][index - 1] << " #{e}"
              next
            end
            candidats[current] ||= []
            candidats[current] << e

            if index == 8
              index = 0
              current += 1
            else
              index += 1
            end
          end
          candidats
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

        candidats_keymap({
          nom: lambda { |c| c[3] + " " + c[4] },
          liste: {index: 5},
          voix: {index: 6}
        })
      end
    end
  end
end
