require 'spec_helper'
require 'weather/weathergetter'
require 'typhoeus'
require 'json'

include Typhoeus

describe WeatherGetter do

  let!(:json) { JSON.parse(IO.read('./spec/fixtures/wunderground_10day.json')) }
  let(:wg) { WeatherGetter.new }
  let(:ww) { WeatherWorker.new }
  let(:zipcode) { 94530 }

  it "gets the weather for 94530" do
    # begin
      forecast = wg.get_forecast(zipcode)
      pp @forecast

      forecast.should include('forecast')
    # rescue
    #   pp 'no netowrk connection or query failed'
    # end
  end

  it "extracts wunderground's 10 day txt_forecast" do
    # begin
      fcd = wg.parse_wunderground_10day(json)
      pp fcd

      # fcd.should include('date')
      fcd.should have(10).items
    # rescue
    #   pp 'no netowrk connection or query failed'
    # end
  end

  it '#make_request' do
    # begin
      ww.class.should == WeatherWorker
      ww.should_not be_nil

      # APIKEY = IO.read('./config/wunderground_apikey.txt').chomp
      url = "http://api.wunderground.com/api/#{APIKEY}/forecast10day/q/#{zipcode}.json"
      pp url
      wg.make_request(url)
      pp @data
    # rescue
    #   pp 'not online or wunderground api call failed'
    # end
  end
end
