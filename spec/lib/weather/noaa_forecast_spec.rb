require 'spec_helper'
require 'weather/noaa_forecast'

describe NOAAForecast do

  before(:all) do
    @fullcount = 29
  end

  it "should instantiate class with valid zipcode" do
    nf = NOAAForecast.new(94530)
    # Write up the error message as a result of the following:
    #nf.class.should = NOAAForecast
    nf.class.should == NOAAForecast
  end

  xit "should not instantiate class with invalid zipcode" do
    nf = NOAAForecast.new('gdf33')
    # Write up the error message as a result of the following:
    #nf.class.should = NOAAForecast
    nf.class.should_not == NOAAForecast
  end

  it "NOAA weather forecast for one week should have 29 elements" do
    nf = NOAAForecast.new(94530,168,6)
    nf.seven_day_weather
    #p nf.noaa_forecast[0].size
    nf.noaa_forecast[0].size.should == @fullcount
  end

  it "temporary hard coded result" do
    nf = NOAAForecast.new(94530,168,6)
    nf.seven_day_weather
    #p nf.noaa_forecast
    nf.noaa_forecast[0][0..5].max.should == 93
  end

  it "NOAA weather forecast blows it's gourd if given nil zipcode" do
    nf = NOAAForecast.new(94530,168,6)
    nf.seven_day_weather
    nf.noaa_forecast[0].size.should == @fullcount
  end

  it "returns latitude and longitude for a given zipcode" do
    nf = NOAAForecast.new(94530,168,6)
    latlong = nf.get_lat_long
    latlong.size.should == 2
  end

end
