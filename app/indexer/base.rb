module VR
  module Indexer
    class Base
      def initialize(config, mapper)
        @config = config
        @mapper = mapper
      end

      def run
        return if event.populated?

        VR.tracer.in_span("index.run") do |span|
          event.areas.delete_all
          event.rounds.delete_all

          @mapper.each do |m|
            run_mapper(m)
          end
        end

        event.update!(populated: true)
      end

      class << self
        private

        @@skip = 0
        @@valid_row = nil
        @@keymap = {}

        def skip(i)
          @@skip = i
        end

        def keymap(map)
          @@keymap = map
        end

        def valid_row?(method)
          @@valid_row = method
        end
      end

      private

      def run_mapper(m)
        VR.tracer.in_span("indexer.run_mapper") do |span|
          round = event.rounds.find_or_create_by!(name: m[:name])
          m[:content].each_with_index do |row, i|
            next if i < @@skip
            next unless @@valid_row.nil? || @@valid_row.call(row)
            run_row(round, parse_row(row))
          end
        end
      end

      def run_row(round, row)
        area = event.areas.find_or_create_by!(name: row[:area_name], path: row[:area_path])
        area.results.find_or_initialize_by(round_id: round.id).tap do |r|
          r.inscrits += row[:inscrits]
          r.abstentions += row[:abstentions]
          r.votants += row[:votants]
          r.blancs += row[:blancs]
          r.nuls += row[:nuls]
          r.exprimes += row[:exprimes]
        end.save!
      end

      def parse_row(row)
        @@keymap.map do |k, v|
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
        @event ||= Event.find_or_create_by!(name: @config[:name], annee: @config[:annee])
      end
    end
  end
end
