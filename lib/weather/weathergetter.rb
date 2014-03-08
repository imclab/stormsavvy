require 'typhoeus'
require 'json'

include Typhoeus

APIKEY = Stormsavvy::Application.config.wunderground_apikey

class WeatherGetter

  attr_reader :forecast, :forecastday

  def initialize
  end

  def display_forecast(zipcode)
    forecast = get_forecast(zipcode)
    @forecastday = parse_wunderground_10day(forecast)
  end

  def get_forecast(zipcode)
    begin
      # wg = WeatherGetter.new
      # WeatherWorker.perform_async(wg.object_id)

      @hydra = Typhoeus::Hydra.new
      url = "http://api.wunderground.com/api/#{APIKEY}/forecast10day/q/#{zipcode}.json"
      @forecast = make_request(url)
      pp 'sleep for 10s between queries'
      sleep(10) # sleep 10s for 10 query/min terms of use
    rescue
      pp 'Wunderground API connection cannot be established'
    end
  end

  def make_request(url)
    request = Typhoeus::Request.new(
      url,
      :method        => :get,
      :timeout       => 5000 # milliseconds
      #:cache_timeout => 60 # seconds
    )
    @hydra.queue(request)
    @hydra.run
    response = request.response

    data = JSON.parse(response.body)
    return data
  end

  def parse_wunderground_10day(forecast)
    # Bad zipcode produces forecast['response']['error']['type'] => "querynotfound"
    # Will need to do some spec for the above.
    @forecastday = forecast['forecast']['simpleforecast']['forecastday']
  end

  def forecast_table(site)
    begin
      pp 'sleep for 10s between queries'
      sleep(10) # sleep 10s for 10 query/min terms of use
      wg = WeatherGetter.new
      zipcode = site.zipcode
      forecast = wg.get_forecast(zipcode)
      forecastday = wg.parse_wunderground_10day(forecast)
      return forecastday
    rescue
      pp 'Wunderground API connection cannot be established'
    end
  end
end
