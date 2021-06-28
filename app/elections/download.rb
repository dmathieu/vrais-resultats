require "faraday"
require "faraday_middleware"

module Elections
  class Download
    def initialize(url)
      @url = url
    end

    def data
      fetch.body
    end

    private

    def fetch
      @resp = client.get(@url)
    end

    def client
      @client ||= Faraday.new do |faraday|
        faraday.use FaradayMiddleware::FollowRedirects
        faraday.adapter Faraday.default_adapter
      end
    end
  end
end
