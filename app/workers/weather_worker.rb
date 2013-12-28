class WeatherWorker
  include Sidekiq::Worker
  sidekiq_options queue: "high"

  def perform(weathergetter_id)
    zipcode = 94530
    @forecast = WeatherGetter.get_forecast(zipcode)
    @forecastday = WeatherGetter.parse_wunderground_10day(@forecast)
  end
end
