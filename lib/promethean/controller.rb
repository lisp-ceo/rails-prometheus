module Promethean
  module Controller

    # returns a default registry
    prometheus = Prometheus::Client.registry

    # create a new counter metric
    HTTP_REQUESTS = Prometheus::Client::Counter.new(:http_requests, 'A counter of HTTP requests made')
    COUNTER_EXAMPLE = Prometheus::Client::Counter.new(:counting_example, 'Counter\'s gotta count, friendo')
    GAUGE_EXAMPLE = Prometheus::Client::Gauge.new(:gauge_example, 'A speedometer recording a boat\'s instantaneous velocity')
    HISTOGRAM_EXAMPLE = Prometheus::Client::Histogram.new(:histogram_example, 'A histogram of how high each user can jump')
    SUMMARY_EXAMPLE = Prometheus::Client::Summary.new(:summary_example, 'A summary of User\'s test scores in COMP1001')

    # Register the metrics with the prom server

      [HTTP_REQUESTS,
       COUNTER_EXAMPLE,
      GAUGE_EXAMPLE,
      HISTOGRAM_EXAMPLE,
      SUMMARY_EXAMPLE].map do |c|
        begin
          prometheus.register(c)
        rescue Prometheus::Client::Registry::AlreadyRegisteredError => e
          next
        end
      end

    def self.included(base)
      base
        .append_before_action :record_request
    end

    def record_request
      HTTP_REQUESTS
        .increment {

      }

    end
    def increment_counter
    end
  end
end
