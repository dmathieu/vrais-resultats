module VR
  module Reducer
    class Legislatives::Annee2017 < Legislatives
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
        VR.tracer.in_span("reducer.parse_data") do |span|
          data = {}
          @mapper.each_with_index do |file, index|
            data = parse_file(file, index, data)
          end
          data.values
        end
      end

      def main_key(row)
        row[1].parameterize + "/" + row[2].to_s
      end

      def row_name(row)
        "#{row[3]} #{row[1]}"
      end

      def parse_file(file, index, data)
        VR.tracer.in_span("reducer.parse_file") do |span|
          file[:content].each_with_index do |row, i|
            next if i < 4
            next if row.empty?
            name = row_name(row)
            next if name == false || name.nil?

            data[main_key(row)] ||= {
              name:,
              path: row[1].parameterize + "/" + row[2].to_s,
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
          name:
        }

        KEYMAP.each do |k|
          h[k[:key]] = k[:default]
        end

        h
      end

      def update_candidats(data, entry)
        VR.tracer.in_span("reducer.update_candidats") do |span|
          entry.drop(20).each_slice(8) do |c|
            nom = [c[2], c[3]].compact.join(" ")
            voix = c[5]
            next if nom.nil? || voix.nil?

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
end
