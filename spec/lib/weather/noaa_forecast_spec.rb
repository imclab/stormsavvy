require 'spec_helper'
require 'weather/noaa_forecast'

describe NOAAForecast do

  # An obvious tautology... ensures paths, etc., a dummy test
  it "should be valid" do
    nf = NOAAForecast.new
    nf.class.should == NOAAForecast
  end

end
