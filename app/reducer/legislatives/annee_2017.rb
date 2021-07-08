module VR
  module Reducer
    module Legislatives
      class Annee2017 < Base
        KEYMAP = [
          {key: :inscrits, index: 6, default: 0},
          {key: :abstentions, index: 7, default: 0},
          {key: :votants, index: 9, default: 0},
          {key: :blancs, index: 11, default: 0},
          {key: :nuls, index: 14, default: 0},
          {key: :exprimes, index: 17, default: 0}
        ]

        private

        def data
          @data ||= parse_data
        end

        def parse_data
          data = {}
          @raw_data.each_with_index do |file, index|
            data = parse_file(file, index, data)
          end
          data.values
        end

        def main_key(row)
          row[1].parameterize + "/" + row[2].to_s
        end

        def row_name(row)
          "#{row[3]} #{row[1]}"
        end

        def build_breadcrumb(row)
          [
            {
              name: @config[:name],
              path: "/" + @config[:name].parameterize
            },
            {
              name: row[1],
              path: "/" + @config[:name].parameterize + "/" + row[1].parameterize,
              type: :departement
            },
            {
              name: row_name(row),
              path: "/" + @config[:name].parameterize + "/" + row[1].parameterize + "/" + row[2].to_s
            }
          ]
        end

        def parse_file(file, index, data)
          file[:content].each_with_index do |row, i|
            next if i < 4
            next if row.empty?
            name = row_name(row)
            next if name == false || name.nil?

            data[main_key(row)] ||= {
              breadcrumb: build_breadcrumb(row),
              name: name,
              resultats: []
            }
            l = data[main_key(row)][:resultats][index] || default_hash(row, file[:name])

            KEYMAP.each do |k|
              l[k[:key]] += row[k[:index]]
            end

            l[:candidats] = update_candidats(l[:candidats], row)

            data[main_key(row)][:resultats][index] = l
          end

          data
        end

        def default_hash(entry, name)
          h = {
            candidats: [],
            name: name
          }

          KEYMAP.each do |k|
            h[k[:key]] = k[:default]
          end

          h
        end

        def update_candidats(data, entry)
          entry.drop(20).each_slice(8) do |c|
            nom = c[2]
            prenom = c[3]
            voix = c[5]
            next if nom.nil? || prenom.nil? || voix.nil?

            existing = data.find_index { |s| s[:nom] == nom && s[:prenom] == prenom }
            if existing
              data[existing][:voix] += voix
              next
            end

            data << {
              nom: nom,
              prenom: prenom,
              liste: "",
              voix: voix
            }
          end

          data
        end
      end
    end
  end
end
