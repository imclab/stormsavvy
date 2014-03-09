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
    # wg = WeatherGetter.new
    # WeatherWorker.perform_async(wg.object_id)
    begin
      @hydra = Typhoeus::Hydra.new
      url = "http://api.wunderground.com/api/#{APIKEY}/forecast10day/q/#{zipcode}.json"
      @forecast = make_request(url)
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
      pp 'sleep for 7s between queries'
      sleep(7) # sleep 7s for 10 query/min terms of use
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
