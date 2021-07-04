require "roo"

module VR
  module Mapper
    class Xlsx < Base
      def content
        raw_data.map do |v|
          {
            name: v[:name],
            content: parse_file(Roo::Excelx.new(v[:path]))
          }
        end
      end

      private

      def parse_file(content)
        entries = []
        i = 0
        content.sheet(0).each_row_streaming do |row|
          entries[i] ||= []
          row.each do |cell|
            coord = cell.coordinate
            entries[i][coord[1] - 1] = cell.value
          end

          i += 1
        end
        entries
      end
    end
  end
end
