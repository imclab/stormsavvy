require 'weather/weathergetter'
require 'redis'
require 'sidekiq'

class WeatherWorker
  include Sidekiq::Worker
  sidekiq_options queue: "high"

  def perform(zipcode)
    wg = WeatherGetter.new
    wg.get_forecast(zipcode)
  end
end
