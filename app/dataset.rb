require "json"

module VR
  class Dataset
    include Enumerable

    @@path_dir = File.expand_path("..", __dir__)
    def self.set_path_dir(path)
      @@path_dir = path
    end

    def initialize(path)
      @path = path
    end

    def each(&block)
      config.each do |c|
        block.call(c)
      end
    end

    private

    def config
      @config ||= JSON.parse(fetch.read).map(&:deep_symbolize_keys)
    end

    def fetch
      @data = File.open(File.expand_path(@path))
    end

    def cache_path(config)
      File.join(@@path_dir, "cache", "dataset", "#{config[:reducer]}-#{config[:annee]}.json")
    end
  end
end
