require "active_support"
require "active_support/core_ext"

module VR
  def self.env
    ENV["VR_ENV"] || "prod"
  end

  def self.database_env
    ENV["VR_DATABASE_ENV"] || "production"
  end

  def self.tracer
    OpenTelemetry.tracer_provider.tracer("vr")
  end
end

root = File.dirname(File.absolute_path(__FILE__))
Dir.glob(File.join(root, "initializers/*.rb")) { |file| require file }
Dir.glob(File.join(root, "models/*.rb")) { |file| require file }

require "dataset"
require "fetcher"
require "indexer"
require "mapper"
require "reducer"
