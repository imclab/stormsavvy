## Get forecast from wunderground

require 'typhoeus'
require 'json'

include Typhoeus

# APIKEY = IO.read("./config/wunderground_api_key.rb")
APIKEY = ENV['WUNDERGROUND_APIKEY']

class WeatherGetter

  attr_reader :forecast, :forecastday

  def initialize
  end

  def get_forecast(zipcode)
    @hydra = Typhoeus::Hydra.new
    url = "http://api.wunderground.com/api/#{APIKEY}/forecast10day/q/#{zipcode}.json"
    @forecast = make_request(url)
  end


  def make_request(url)

    request = Typhoeus::Request.new(url,
            :method        => :get,
            :timeout       => 5000, # milliseconds
            :cache_timeout => 60) # seconds
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

end