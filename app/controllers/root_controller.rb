class RootController < ApplicationController
  include Promethean::Controller

  def alert_manager
    redirect_to ENV['ALERT_MANAGER']
  end

  # Counter is a metric that exposes merely a sum or tally of things.
  def counter
    COUNTER_EXAMPLE
      .increment service: 'GiftCardService'
    # Next query the counter for a given label set
    @counter_value = COUNTER_EXAMPLE
                       .get service: 'GiftCardService'
  end

  # A route that raises a 500 :(((((((
  def error
    # Logging exception handling
    # Logging backtrace / context info
    respond_to do |f|
      f.any do
        render json: {
                 error: "An error has occured. Server administrators have been alerted.",
               }, status: 500
      end
    end
  end

  # A route that raises a fo'oh'fo - file not found
  def fnf
    respond_to do |f|
      f.any do
        render json: {
                 error: "File Not Found",
               }, status: 404
      end
    end
  end

  # Gauge is a metric that exposes merely an instantaneous value or some snapshot thereof.
  def gauge
    GAUGE_EXAMPLE
      .set({vehicle: :fastest_speed_boat}, Random.rand * 9000 * 2)
    @gauge_value = GAUGE_EXAMPLE
                     .get vehicle: :fastest_speed_boat
  end

  def grafana
    redirect_to ENV['GRAFANA']
  end

  # A histogram samples observations (usually things like request durations or response sizes) and counts
  # them in configurable buckets. It also provides a sum of all observed values.
  def histogram
    # Record a value
    @new_value = Random.rand
    HISTOGRAM_EXAMPLE.observe({service: :jumping_users}, @new_value)
    # Retrieve the current bucketed values
    @observations = HISTOGRAM_EXAMPLE.get(service: :jumping_users)
  end

  def index; end

  def kubernetes_dashboard
    redirect_to ENV['KUBERNETES_DASHBOARD']
  end

  def prometheus
    redirect_to ENV['PROMETHEUS']
  end

  # Summary, similar to histograms, is an accumulator for samples.
  # It captures Numeric data and provides an efficient percentile calculation mechanism.
  def summary
    @new_value = Random.rand * 100
    SUMMARY_EXAMPLE.observe({service: :test_scores_users}, @new_value)
    @observations = SUMMARY_EXAMPLE.get(service: :test_scores_users)
  end
end
