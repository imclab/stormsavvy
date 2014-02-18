require 'typhoeus'
require 'json'

include Typhoeus

# if(Rails.env == 'development' || Rails.env == 'staging')
#   APIKEY = IO.read('./config/wunderground_apikey.txt').chomp
# elsif(Rails.env == 'production')
#   APIKEY = ENV['WUNDERGROUND_APIKEY']
# end
APIKEY = Stormsavvy::Application.config.wunderground_apikey

class WeatherGetter

  attr_reader :forecast, :forecastday

  def initialize
  end

  def display_forecast
    @zipcode = 94530
    @forecast = get_forecast(@zipcode)
    @forecastday = parse_wunderground_10day(@forecast)

    # @weathergetter = WeatherGetter.new
    # WeatherWorker.perform_async(@weathergetter.object_id)
  end

  def get_forecast(zipcode)
    sleep(30) # sleep 30s for 10 query/min terms of use
    @hydra = Typhoeus::Hydra.new
    url = "http://api.wunderground.com/api/#{APIKEY}/forecast10day/q/#{zipcode}.json"
    @forecast = make_request(url)
  end

  def make_request(url)
    request = Typhoeus::Request.new(
      url,
      :method        => :get,
      :timeout       => 5000#, # milliseconds
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
    wg = WeatherGetter.new
    zipcode = site.zipcode
    forecast = wg.get_forecast(zipcode)
    forecastday = wg.parse_wunderground_10day(forecast)
    return forecastday
  end
end
