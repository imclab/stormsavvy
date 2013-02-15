require 'spec_helper'
require 'weather/redis_forecast'
require 'weather/noaa_forecast'

describe RedisForecast do

  before(:each) do
    @nf = double(NOAAForecast)
    @nf.stub(:get_lat_long).with(94530).and_return([37.9202057, -122.2937428])
    @nf.stub(:ping_noaa).with([37.92, -122.29], 168, 6) do
      IO.read("./spec/lib/weather/noaa_response.xml")
    end
    @nf.stub(:get_forecast).with(@nf.get_lat_long(94530)) do
      response = @nf.ping_noaa([37.92, -122.29], 168, 6)
      nf = NOAAForecast.new(94530)
      nf.parse_weather_data(response)
    end
    @nf.stub(:seven_day_weather) do
      latlong = @nf.get_lat_long(94530)
      @nf.get_forecast(latlong)
    end

    @rf = RedisForecast.new
  end

  it "creates redis object" do
    @rf.class.should == RedisForecast
  end

  it "returns nf stub values" do
    @nf.get_lat_long(94530).should == [37.9202057, -122.2937428]
  end

  it "sets lat long values" do
    lat_long = @nf.get_lat_long(94530)
    $redis.set('lat', lat_long[0])
    $redis.set('long', lat_long[1])
    $redis.get('lat').should == lat_long[0].to_s
    $redis.get('long').should == lat_long[1].to_s
  end

  it "sets zipcode using set_lat_long" do
    @rf.set_lat_long(94530)
    $redis.get('lat').should == 37.9202057.to_s
    $redis.get('long').should == -122.2937428.to_s
  end

  it "gets lat long" do
    zipcode = 94530
    nf = NOAAForecast.new(zipcode)
    lat_long = nf.get_lat_long(zipcode)
    $redis.zadd(zipcode, lat_long[0], lat_long[1])
    print $redis.get('zipcode')

    # @rf.get_lat_long(94530).should == [37.9202057.to_s, -122.2937428.to_s]
  end
end
