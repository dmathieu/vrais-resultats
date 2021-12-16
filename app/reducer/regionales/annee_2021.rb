module VR
  module Reducer
    class Regionales::Annee2021 < Regionales
      KEYMAP = [
        {key: :inscrits, index: 2, default: 0},
        {key: :abstentions, index: 3, default: 0},
        {key: :votants, index: 5, default: 0},
        {key: :blancs, index: 7, default: 0},
        {key: :nuls, index: 10, default: 0},
        {key: :exprimes, index: 13, default: 0}
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
        row[1].parameterize
      end

      def row_name(row)
        row[1]
      end

      def parse_file(file, index, data)
        VR.tracer.in_span("reducer.parse_file") do |span|
          file[:content].each_with_index do |row, i|
            next if i < 1
            next if row.compact.empty?
            name = row_name(row)
            next if name == false || name.nil?

            data[main_key(row)] ||= {
              name: name,
              path: row[1].parameterize,
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
          entry.drop(16).each_slice(9) do |c|
            next if c.compact.empty?
            nom = c[4]
            liste = c[3]
            voix = c[5]
            next if nom.nil? || voix.nil?

            existing = data.find_index { |s| s[:nom] == nom }
            if existing
              data[existing][:voix] += voix
              next
            end

            data << {
              nom: nom,
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
