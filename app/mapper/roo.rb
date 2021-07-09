require "roo"
require "roo-xls"

module VR
  module Mapper
    class Roo < Base
      include Enumerable

      def each(&block)
        raw_data.each do |v|
          VR.tracer.in_span("mapper.each") do |span|
            span.set_attribute("mapper", v[:name])
            block.call({
              name: v[:name],
              content: spreadsheet(v)
            })
          end
        end
      end

      private

      def spreadsheet(v)
        VR.tracer.in_span("mapper.open") do |span|
          ::Roo::Spreadsheet.open(v[:path]).sheet(0)
        end
      end
    end
  end
end
