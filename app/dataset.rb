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
        c.each do |f|
          VR.tracer.in_span("dataset.#{f[:name].parameterize}") do |span|
            mapper = VR::Mapper.new(f)
            path = cache_path(f)

            unless File.exist?(path)
              r = VR::Reducer.find(f, mapper)
              File.write(path, r.content.to_json)
            end

            block.call(JSON.parse(File.read(path)).deep_symbolize_keys)
          end
        end
      end
    end

    private

    def config
      @config ||= Dir.glob(@path + "/**/*.json").map do |f|
        JSON.parse(File.read(File.expand_path(f))).map(&:deep_symbolize_keys)
      rescue JSON::ParserError => e
        raise "JSON parse error in #{f}: #{e}"
      end
    end

    def cache_path(config)
      File.join(@@path_dir, "cache", "dataset", "#{config[:reducer]}-#{config[:annee]}.json")
    end
  end
end
