require "json"

module Elections
  class Dataset
    def initialize(path)
      @path = path
    end

    def entries
      content.lazy.map do |config|
        case config["format"]
        when "xlsx"
          XlsxEntry.new(get_dataset(config))
        else
          raise "unknown format #{config["format"]}"
        end
      end
    end

    private

    def fetch
      @data = File.open(File.expand_path(@path))
    end

    def content
      @content ||= JSON.parse(fetch.read)
    end

    def get_dataset(config)
      Elections::Download.new(config["url"]).data
    end
  end
end

require "elections/dataset/xlsx_entry"
