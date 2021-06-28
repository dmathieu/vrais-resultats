module Elections
  class Dataset
    class Base
      def initialize(config, data)
        @raw_data = data
        @config = config
      end

      def name
        @config["name"]
      end

      def save
        File.write(File.join("datasets", "#{@config["slug"]}.#{@config["format"]}"), @raw_data)
      end
    end
  end
end
