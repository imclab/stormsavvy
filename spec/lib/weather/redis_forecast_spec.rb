require 'spec_helper'
require 'weather/redis_forecast'

describe RedisForecast do

  it "creates redis object" do
    rf = RedisForecast.new
    rf.class.should == RedisForecast
  end
end
