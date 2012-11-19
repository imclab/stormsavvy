require 'spec_helper'
require 'weather/noaa_forecast'

describe NOAAForecast do

  before(:each) do
    @fullcount = 29
    @nf = double(NOAAForecast)
    @nf.stub(:get_lat_long).with(94530).and_return([37.9202057, -122.2937428])
    @nf.stub(:ping_noaa).with([-122.0, 38.00], 168, 6) do
      IO.read("./spec/lib/weather/noaa_response.xml")
    end
    @nf.stub(:seven_day_weather)
  end

  it "should instantiate class with valid zipcode" do
    nf = NOAAForecast.new(94530)
    nf.class.should == NOAAForecast
  end

  xit "NOAA weather forecast for one week should have 29 elements" do
    nf = NOAAForecast.new(94530,168,6)
    nf.seven_day_weather
    puts nf.xml
    #p nf.noaa_forecast[0].size
    nf.noaa_forecast[0].size.should == @fullcount
  end

  it "NOAA weather forecast blows its gourd if given nil zipcode" do
    #nf = NOAAForecast.new(94530,168,6)
    @nf.seven_day_weather
    @nf.noaa_forecast[0].size.should == @fullcount
  end

  it "returns latitude and longitude for a given zipcode" do
    latlong = @nf.get_lat_long 94530
    latlong.size.should == 2
    tol = 0.0001
    latlong[0].should be_within(tol).of(37.9202057)
    latlong[1].should be_within(tol).of(-122.2937428)
  end

  it "gets data from noaa" do
   response = @nf.ping_noaa([-122.0, 38.00], 168, 6)
   # PUT AN ASSERTION HERE
  end

end
