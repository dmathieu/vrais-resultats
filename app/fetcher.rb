require "faraday"
require "faraday_middleware"

module VR
  class Fetcher
    @@path_dir = File.expand_path("..", __dir__)
    def self.set_path_dir(path)
      @@path_dir = path
    end

    def self.fetch(config)
      new(config).fetch
    end

    def initialize(config)
      @config = config
    end

    def fetch
      @config[:data].each_with_index.map do |v, k|
        path = cache_path(k)
        File.write(path, download(v[:url]).body) unless File.exist?(path)
        {name: v[:name], path:}
      end
    end

    private

    def cache_path(name)
      File.join(@@path_dir, "cache", "fetcher", "#{@config[:reducer]}-#{@config[:annee]}.#{name}.#{@config[:format]}")
    end

    def download(url)
      client.get(url)
    end

    def client
      @client ||= Faraday.new do |faraday|
        faraday.use FaradayMiddleware::FollowRedirects
        faraday.adapter Faraday.default_adapter
      end
    end
  end
end
