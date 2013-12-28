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
      pp forecast

      forecast.should include('response')
      forecast.should include('forecast')
      forecast.should have(2).items
    # rescue
    #   pp 'no network connection or query failed'
    # end
  end

  it "extracts wunderground's 10 day txt_forecast" do
    # begin
      forecast = wg.parse_wunderground_10day(json)
      forecast.should have(10).items
    # rescue
    #   pp 'no network connection or query failed'
    # end
  end

  it '#display_forecast' do
    # begin
      ww.class.should == WeatherWorker
      ww.should_not be_nil

      forecast = wg.display_forecast
      forecast.should have(24).items
    # rescue
    #   pp 'no network connection or query failed'
    # end
  end
end
