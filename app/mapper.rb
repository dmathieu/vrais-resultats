# frozen_string_literal: true

module VR
  module Mapper
    def self.new(config)
      case config[:format].to_sym
      when *::Roo::CLASS_FOR_EXTENSION.keys
        VR::Mapper::Roo.new(config)
      else
        raise "unknown format #{config[:format]}"
      end
    end
  end
end

require 'mapper/base'
require 'mapper/roo'
