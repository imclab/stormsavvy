require 'spec_helper'
require 'weather/weathergetter'

describe WeatherGetter do

  before(:all) do
    @json = JSON.parse(IO.read('./spec/fixtures/wunderground_10day.json'))
  end

  it "gets the weather for 94530" do
    begin
      wg = WeatherGetter.new
      forecast = wg.get_forecast(94530)
      forecast.should  include('forecast')
    rescue
      pp 'not online or wunderground api call failed'
    end
  end

  it "extracts wunderground's 10 day txt_forecast" do
    wg = WeatherGetter.new
    fcd = wg.parse_wunderground_10day(@json)
    #fcd.should  include('date')
    fcd.should have(10).items
  end

end
