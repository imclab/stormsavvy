require 'weather/weathergetter'
require 'redis'
require 'sidekiq'

class WundergroundWorker

  include Sidekiq::Worker
  sidekiq_options queue: "high"

  def perform(site_id)
    site = Site.find(site_id)
    wg = WeatherGetter.new
    wg.forecast_table(site)
  end
end
