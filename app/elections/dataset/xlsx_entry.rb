require "tempfile"
require "roo"

module Elections
  class Dataset
    class XlsxEntry
      def initialize(data)
        @raw_data = data
      end

      def content
        entries = []

        i = 0
        data.sheet(0).each_row_streaming do |row|
          entries[i] ||= []
          row.each do |cell|
            coord = cell.coordinate
            entries[i][coord[1] - 1] = cell.value
          end

          i += 1
        end

        entries
      end

      private

      def data
        @data ||= Roo::Excelx.new(@raw_data)
      end
    end
  end
end
