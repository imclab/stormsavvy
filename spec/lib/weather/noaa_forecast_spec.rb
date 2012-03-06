require 'spec_helper'
require 'weather/noaa_forecast'

describe NOAAForecast do

  it "should be valid" do
    nf = NOAAForecast.new
    nf.should be_valid
  end

end
