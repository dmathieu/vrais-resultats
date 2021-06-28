require 'json'

module Elections
  class Dataset
    def initialize(path)
      @path = path
    end

    def entries
      content.map do |c|
        Entry.new(c)
      end
    end

    private
    def fetch
      @data = File.open(File.expand_path(@path))
    end

    def content
      @content ||= JSON.parse(fetch.read)
    end

    class Entry
      def initialize(config)
        @config = config
      end

      def content
        @content ||= Elections::Download.new(@config["url"]).data
      end
    end
  end
end
