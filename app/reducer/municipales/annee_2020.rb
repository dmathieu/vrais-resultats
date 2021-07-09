module VR
  module Reducer
    module Municipales
      class Annee2020 < Base
        NAMEKEY = 3
        KEYMAP = [
          {key: :inscrits, index: 5, default: 0},
          {key: :abstentions, index: 6, default: 0},
          {key: :votants, index: 8, default: 0},
          {key: :blancs, index: 10, default: 0},
          {key: :nuls, index: 13, default: 0},
          {key: :exprimes, index: 16, default: 0}
        ]

        private

        def data
          @data ||= parse_data
        end

        def parse_data
          VR.tracer.in_span("reducer.parse_data") do |span|
            data = {}
            @mapper.each_with_index do |file, index|
              data = parse_file(file, index, data)
            end
            data.values.select { |e| e[:resultats].any? { |r| !r.nil? && r[:inscrits] >= 1000 } }
          end
        end

        private

        def main_key(row)
          row[1].parameterize + "/" + row[NAMEKEY].parameterize
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
              name: row[NAMEKEY],
              path: "/" + @config[:name].parameterize + "/" + row[1].parameterize + "/" + row[NAMEKEY].parameterize
            }
          ]
        end

        def parse_file(file, index, data)
          VR.tracer.in_span("reducer.parse_file") do |span|
            file[:content].each_with_index do |row, i|
              next if i == 0
              next if row[NAMEKEY] == false || row[NAMEKEY].nil?
              next if row.empty?

              data[main_key(row)] ||= {
                breadcrumb: build_breadcrumb(row),
                name: row[NAMEKEY],
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
          VR.tracer.in_span("reducer.update_candidats") do |span|
            candidats = []

            current = 0
            cdata = entry.dup.drop(19)
            candidats[0] = [cdata[0]]
            cdata.each_cons(3) do |prev, cur, nex|
              if prev.is_a?(Numeric) && cur.is_a?(Numeric) && nex.is_a?(String)
                current += 1
                candidats[current] = []
              end
              candidats[current] << cur
            end
            candidats[current] << data.last

            candidats.each do |c|
              nom = c[3] || ""
              prenom = c[4] || ""
              liste = c[5] || ""
              while c[6].is_a?(String)
                liste += " " + c[6]
                c.delete_at(6)
              end
              voix = c[6]

              existing = data.find_index { |s| s[:nom] == nom && s[:prenom] == prenom }
              if existing
                data[existing][:voix] += voix
                next
              end

              data << {
                nom: nom,
                prenom: prenom,
                liste: liste,
                voix: voix
              }
            end

            data
          end
        end
      end
    end
  end
end
