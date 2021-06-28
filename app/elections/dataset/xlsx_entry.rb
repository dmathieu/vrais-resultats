require 'tempfile'
require 'roo'

module Elections
  class Dataset
    class XlsxEntry
      def initialize(config)
        @config = config
      end

      def content
        entries = []

        i = 0
        data.sheet(0).each_row_streaming do |row|
          entries[i] ||= []
          j = 0
          row.map do |cell|
            entries[i][j] = cell.value
            j+=1
          end

          i+=1
        end

        entries
      end

      private

      def data
        @data ||= Roo::Excelx.new(StringIO.new(Elections::Download.new(@config["url"]).data))
      end
    end
  end
end
