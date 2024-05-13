# frozen_string_literal: true

module VR
  module Mapper
    class Base
      def initialize(config)
        @config = config
      end

      def content
        raise NotImplementedError
      end

      private

      def raw_data
        @raw_data ||= VR::Fetcher.fetch(@config)
      end
    end
  end
end
