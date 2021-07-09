require "roo"
require "roo-xls"

module VR
  module Mapper
    class Roo < Base
      include Enumerable

      def each(&block)
        raw_data.each do |v|
          block.call({
            name: v[:name],
            content: ::Roo::Spreadsheet.open(v[:path]).sheet(0).lazy
          })
        end
      end
    end
  end
end
