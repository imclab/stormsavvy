require 'spec_helper'
require 'weather/weathergetter'
require 'typhoeus'
require 'json'

include Typhoeus

describe WeatherGetter do

  let(:json) { JSON.parse(IO.read('./spec/fixtures/wunderground_10day.json')) }
  let(:wg) { WeatherGetter.new }
  let(:ww) { WeatherWorker.new }
  let(:zipcode) { 94530 }
  let(:forecast) { wg.get_forecast(zipcode) }
  let(:forecastday) { wg.parse_wunderground_10day(json) }
  let(:site) { FactoryGirl.build(:site) }

  it "gets the weather for 94530" do
    wg.should respond_to(:get_forecast)
    forecast.should include('response')
    forecast.should include('forecast')
    forecast.should have(2).items
  end

  it "extracts wunderground's 10 day txt_forecast" do
    wg.should respond_to(:parse_wunderground_10day)
    forecastday.should have(10).items
  end

  it 'extracts forecast using site zipcode' do
    forecast = wg.get_forecast(site.zipcode)
    forecastday = wg.parse_wunderground_10day(forecast)
    forecastday.should have(10).items
  end

  it '#display_forecast' do
    ww.class.should == WeatherWorker
    ww.should_not be_nil

    forecast = wg.display_forecast
    forecast.should have(10).items
  end
end
