module VR
  module Indexer
    def self.new(config, mapper)
      const_get(config[:reducer].camelize)
        .const_get("Annee#{config[:annee]}")
        .new(config, mapper)
    end
  end
end

root = File.dirname(File.absolute_path(__FILE__))
Dir.glob(File.join(root, "indexer/**/*.rb")) { |file| require file }
