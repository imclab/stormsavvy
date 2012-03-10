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
    nf.seven_day_temp(94530)
    nf.noaa_forecast[0].size.should == @fullcount
  end

end
