module Elections
  module Renderer
    class Municipales
      MAINKEY = 3
      KEYMAP = [
        {key: :inscrits, index: 5, default: 0},
        {key: :abstentions, index: 6, default: 0},
        {key: :votants, index: 8, default: 0},
        {key: :blancs, index: 10, default: 0},
        {key: :nuls, index: 13, default: 0},
        {key: :exprimes, index: 16, default: 0}
      ]

      def initialize(data)
        @data = data
      end

      def content
        @content ||= parse_data
      end

      private

      def parse_data
        data = {}

        @data.each_with_index do |e, i|
          next if i == 0

          l = data[e[MAINKEY]] || default_hash(e)

          KEYMAP.each do |k|
            l[k[:key]] += e[k[:index]]
          end

          l[:candidats] = update_candidats(l[:candidats], e)

          data[e[MAINKEY]] = l
        end

        data
      end

      private

      def default_hash(entry)
        h = {department: entry[0], candidats: []}

        KEYMAP.each do |k|
          h[k[:key]] = k[:default]
        end

        h
      end

      def update_candidats(data, entry)
        entry.dup.drop(19).each_slice(9).to_a.each do |e|
          existing = data.find_index { |s| s[:nom] == e[3] && s[:prenom] == e[4] }
          if existing
            data[existing][:voix] += e[6]
            next
          end

          data << {
            nom: e[3],
            prenom: e[4],
            liste: e[5],
            voix: e[6]
          }
        end

        data
      end
    end
  end
end
