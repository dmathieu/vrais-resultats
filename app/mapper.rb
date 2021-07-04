module VR
  module Mapper
    def self.new(config)
      case config[:format]
      when "xlsx"
        VR::Mapper::Xlsx.new(config)
      else
        raise "unknown format #{config[:format]}"
      end
    end
  end
end

require "mapper/base"
require "mapper/xlsx"
