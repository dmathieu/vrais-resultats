require "roo"
require "roo-xls"

module VR
  module Mapper
    class Roo < Base
      def content
        raw_data.map do |v|
          {
            name: v[:name],
            content: parse_file(::Roo::Spreadsheet.open(v[:path]))
          }
        end
      end

      private

      def parse_file(content)
        entries = []
        content.sheet(0).each do |row|
          entries << row
        end
        entries
      end
    end
  end
end
