require 'faraday'

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
      @resp = Faraday.get(@url)
    end
  end
end
