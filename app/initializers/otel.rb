# frozen_string_literal: true

require 'opentelemetry'
require 'opentelemetry-api'
require 'opentelemetry-sdk'
require 'opentelemetry/exporter/otlp'

require 'faraday'
require 'faraday_middleware'
require 'opentelemetry-instrumentation-faraday'

OpenTelemetry::SDK.configure do |c|
  c.service_name = 'vrais-resultats'
  c.use_all

  if ENV.key?('HONEYCOMB_API_KEY')
    c.add_span_processor(
      OpenTelemetry::SDK::Trace::Export::BatchSpanProcessor.new(
        OpenTelemetry::Exporter::OTLP::Exporter.new(
          endpoint: 'https://api.honeycomb.io/v1/traces',
          headers: {
            'x-honeycomb-team': ENV['HONEYCOMB_API_KEY'],
            'x-honeycomb-dataset': 'vrais-resultats'
          }
        )
      )
    )
  end
end
