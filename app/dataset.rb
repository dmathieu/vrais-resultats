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
        VR.tracer.in_span("dataset.#{c[:name].parameterize}") do |span|
          mapper = VR::Mapper.new(c)
          path = cache_path(c)

          unless File.exist?(path)
            r = VR::Reducer.new(c, mapper)
            File.write(path, r.content.to_json)
          end

          block.call(JSON.parse(File.read(path)).deep_symbolize_keys)
        end
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
