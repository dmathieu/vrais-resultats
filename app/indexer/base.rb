module VR
  module Indexer
    class Base
      def initialize(config, mapper)
        @config = config
        @mapper = mapper
      end

      def run
        VR.tracer.in_span("index.run") do |span|
          @mapper.each do |m|
            run_mapper(m)
          end
        end
      end

      private

      def self.set_skip(i)
        @@skip = i
      end

      def self.set_keymap(map)
        @@keymap = map
      end

      def run_mapper(m)
        VR.tracer.in_span("indexer.run_mapper") do |span|
          round = event.rounds.find_or_create_by!(name: m[:name])
          m[:content].each_with_index do |row, i|
            next if i < @@skip
            run_row(round, parse_row(row))
          end
        end
      end

      def run_row(round, row)
        area = event.areas.find_or_create_by!(name: row[:area_name], path: row[:area_path])
      end

      def parse_row(row)
        @@keymap.map do |k,v|
          value = nil
          case v
          when Hash
            value = row[v[:index]]
          when Proc
            value = v.call(row)
          end

          [k, value]
        end.to_h
      end

      def event
        @event ||= Event.find_or_create_by!(name: @config[:name])
      end
    end
  end
end
