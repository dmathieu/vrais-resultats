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

      def self.set_keymap(map)
        @@keymap = map
      end

      def run_mapper(m)
        VR.tracer.in_span("indexer.run_mapper") do |span|
          round = event.rounds.find_or_create_by!(name: m[:name])
          m[:content].each do |row|
            run_row(round, row)
          end
        end
      end

      def run_row(round, row)
        nil
      end

      def event
        @event ||= Event.find_or_create_by!(name: @config[:name])
      end
    end
  end
end
