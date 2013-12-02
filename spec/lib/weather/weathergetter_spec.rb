require 'spec_helper'
require 'weather/weathergetter'

describe WeatherGetter do

  before(:all) do
    @json = JSON.parse(IO.read('./spec/fixtures/wunderground_10day.json'))
  end

  it "gets the weather for 94530" do
    wg = WeatherGetter.new
    forecast = wg.get_forecast(94530)
    forecast.should  include('forecast')
  end

  it "extracts wunderground's 10 day txt_forecast" do
    wg = WeatherGetter.new
    fcd = wg.parse_wunderground_10day(@json)
    #fcd.should  include('date')
    fcd.should have(10).items
  end

end
