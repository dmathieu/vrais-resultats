require "opentelemetry"
require "opentelemetry-api"
require "opentelemetry-sdk"
require "opentelemetry/exporters/honeycomb"

require "faraday"
require "faraday_middleware"
require "opentelemetry-instrumentation-faraday"

OpenTelemetry::SDK.configure do |c|
  c.use_all

  if ENV.key?("HONEYCOMB_API_KEY")
    c.add_span_processor(
      OpenTelemetry::SDK::Trace::Export::BatchSpanProcessor.new(
        OpenTelemetry::Exporters::Honeycomb::Exporter.new(
          writekey: ENV["HONEYCOMB_API_KEY"],
          dataset: "vrais-resultats"
        )
      )
    )
  end
end
