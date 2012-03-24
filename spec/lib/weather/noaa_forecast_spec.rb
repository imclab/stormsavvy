require 'spec_helper'
require 'weather/noaa_forecast'

describe NOAAForecast do

  before(:all) do
    @fullcount = 29
  end

  it "should instantiate with valid class" do
    nf = NOAAForecast.new(94530,168,6)
    # Write up the error message as a result of the following:
    #nf.class.should = NOAAForecast
    nf.class.should == NOAAForecast
  end

  it "NOAA weather forecast for one week should have 29 elements" do
    nf = NOAAForecast.new(94530,168,6)
    nf.seven_day_weather(94530)
    p nf.noaa_forecast[0].size
    nf.noaa_forecast[0].size.should == @fullcount
  end

  it "temporary hard coded result" do
    nf = NOAAForecast.new(94530,168,6)
    nf.seven_day_weather(94530)
    #p nf.noaa_forecast
    nf.noaa_forecast[0][0..5].max.should == 51
  end

  xit "NOAA weather forecast blows it's gourd if given nil zipcode" do
    nf = NOAAForecast.new(94530,168,6)
    nf.seven_day_weather(nil)
    nf.noaa_forecast[0].size.should == @fullcount
  end

  it "requires a valid zipcode for retrieving lat long" do
    nf = NOAAForecast.new(94530,168,6)
    latlong = nf.get_lat_long(94530)
    latlong.size.should == 2
  end

  xit "requires a valid zipcode for retrieving lat long" do
    nf = NOAAForecast.new(94530,168,6)
    latlong = nf.get_lat_long(nil)
    latlong.size.should == 2
  end
end
