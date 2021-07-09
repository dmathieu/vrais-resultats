require "active_support"
require "active_support/core_ext"
require "otel"

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
