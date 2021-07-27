require "active_support"
require "active_support/core_ext"

root = File.dirname(File.absolute_path(__FILE__))
Dir.glob(File.join(root, "initializers/*.rb")) { |file| require file }

module VR
  def self.env
    ENV["VR_ENV"] || "prod"
  end

  def self.tracer
    OpenTelemetry.tracer_provider.tracer("vr")
  end
end

require "dataset"
require "fetcher"
require "mapper"
require "reducer"
