require "json"

module Elections
  class Dataset
    def initialize(path)
      @path = path
    end

    def entries
      content.map do |c|
        case c["format"]
        when "xlsx"
          XlsxEntry.new(c)
        else
          raise "unknown format #{c["format"]}"
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
  end
end

require 'elections/dataset/xlsx_entry'
