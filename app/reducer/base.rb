# frozen_string_literal: true

module VR
  module Reducer
    class Base
      def initialize(config, mapper)
        @config = config
        @mapper = mapper
      end

      def content
        @content ||= {
          name: @config[:name],
          annee: @config[:annee],
          data:
        }
      end

      private

      def data
        @data ||= parse_data
      end

      def parse_data
        VR.tracer.in_span('reducer.parse_data') do |_span|
          data = {}
          @mapper.each_with_index do |file, index|
            data = parse_file(file, index, data)
          end
          data.values
        end
      end

      def parse_file(file, index, data)
        VR.tracer.in_span('reducer.parse_file') do |_span|
          file[:content].each_with_index do |row, i|
            @header = row if header_row == i
            next if skip_row_if(i, row)
            next if row.empty?
            next if row_name(row) == false || row_name(row).nil?

            data[row_path(row)] ||= default_row(row)
            l = data[row_path(row)][:resultats][index] || default_result(row, file[:name])

            keymap.each do |k|
              l[k[:key]] += if k.key?(:fn)
                              k[:fn].call(row).to_i
                            else
                              row[k[:index]].to_i
                            end
            end

            l[:candidats] = update_candidats(l[:candidats], row)

            data[row_path(row)][:resultats][index] = l
          end

          data
        end
      end

      def default_result(_entry, name)
        h = {
          candidats: [],
          name:
        }

        keymap.each do |k|
          h[k[:key]] = k[:default]
        end

        h
      end

      def default_row(row)
        {
          name: row_name(row),
          path: row_path(row),
          resultats: []
        }
      end

      def update_candidats(data, entry)
        candidats_split(entry) do |c|
          next if c[:nom].nil? || c[:voix].nil?

          existing = data.find_index { |s| s[:nom] == c[:nom] }
          if existing
            data[existing][:voix] += c[:voix]
            next
          end

          data << {
            nom: c[:nom],
            liste: c[:liste],
            voix: c[:voix]
          }
        end

        data
      end

      def keymap
        raise NotImplementedError
      end

      def row_name(row)
        raise NotImplementedError
      end

      def row_path(row)
        raise NotImplementedError
      end

      def skip_row_if(i, row)
        raise NotImplementedError
      end

      def header_row
        nil
      end

      def candidats_split(entry)
        raise NotImplementedError
      end
    end
  end
end
