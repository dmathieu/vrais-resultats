module VR
  module Reducer
    class Presidentielles::Annee2017 < Presidentielles
      KEYMAP = [
        {key: :inscrits, index: 4, default: 0},
        {key: :abstentions, index: 5, default: 0},
        {key: :votants, index: 7, default: 0},
        {key: :blancs, index: 9, default: 0},
        {key: :nuls, index: 12, default: 0},
        {key: :exprimes, index: 15, default: 0}
      ]

      private

      def main_key
        "national"
      end

      def parse_file(file, index, data)
        VR.tracer.in_span("reducer.parse_file") do |span|
          file[:content].each_with_index do |row, i|
            next if i <= 3

            data[main_key] ||= {
              name: "",
              path: "",
              resultats: []
            }
            l = data[main_key][:resultats][index] || default_hash(row, file[:name])

            KEYMAP.each do |k|
              l[k[:key]] += row[k[:index]]
            end

            l[:candidats] = update_candidats(l[:candidats], row)

            data[main_key][:resultats][index] = l
          end

          data
        end
      end

      def default_hash(entry, name)
        h = {
          candidats: [],
          name:
        }

        KEYMAP.each do |k|
          h[k[:key]] = k[:default]
        end

        h
      end

      def update_candidats(data, entry)
        entry.drop(18).each_slice(7) do |c|
          nom = c[2] + " " + c[3]
          voix = c[4]

          existing = data.find_index { |s| s[:nom] == nom }
          if existing
            data[existing][:voix] += voix
            next
          end

          data << {
            nom:,
            liste: "",
            voix:
          }
        end

        data
      end
    end
  end
end
