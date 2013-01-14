require 'spec_helper'
require 'weather/noaa_forecast'

describe NOAAForecast do

  before(:each) do
    # Import from lib/weather.
    @fullcount = 29
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
  end

  it "should instantiate class with valid zipcode" do
    nf = NOAAForecast.new(94530)
    nf.class.should == NOAAForecast
  end

  it "returns latitude and longitude for a given zipcode" do
    latlong = @nf.get_lat_long 94530
    latlong.size.should == 2
    tol = 0.0001
    latlong[0].should be_within(tol).of(37.9202057)
    latlong[1].should be_within(tol).of(-122.2937428)
  end

  it "parses weather data from noaa for one week" do
    response = @nf.ping_noaa([37.92, -122.29], 168, 6)
    nf = NOAAForecast.new(94530,168,6)
    forecast = nf.parse_weather_data(response)
    forecast[0].size.should == @fullcount
  end

  it "procures the 'validDate' from the NOAA response" do
    response = @nf.ping_noaa([37.92, -122.29], 168, 6)
    nf = NOAAForecast.new(94530,168,6)
    dates = nf.get_valid_dates(response)
    dates.size.should == 8
  end

  it "procures forecast creation time from the NOAA response" do
    response = @nf.ping_noaa([37.92, -122.29], 168, 6)
    nf = NOAAForecast.new(94530,168,6)
    creation_time = nf.get_forecast_creation_time(response)
    datehash = DateTime.parse("Sun Nov 18 23:02:24 2012 UTC", "%a %b %d %H:%M:%S %Y %Z")
    creation_time.should == datehash
  end

  it "procures forecast array" do
    response = @nf.ping_noaa([37.92, -122.29], 168, 6)
    nf = NOAAForecast.new(94530,168,6)
    datehash = nf.get_forecast_array
    datehash.should_not be_nil
  end

  it "joins datetime and pop hash tables" do
    response = @nf.ping_noaa([37.92, -122.29], 168, 6)
    nf = NOAAForecast.new(94530,168,6)
    datehash = nf.get_forecast_array

    datehash.each do |f|
      print f
      puts "\n"
    end

    forecast = nf.seven_day_weather
  end

  it "does something with seven day weather" do
    forecast = @nf.seven_day_weather
    forecast[0].size.should == @fullcount
  end

  it "replaces mock forecast with formatted seven_day_forecast" do

    nf = NOAAForecast.new(94530,168,6)
    nf2 = nf.seven_day_weather
    print "1st element of seven_day_weather array is #{nf2[0]}", "\n"
    print "2nd element of seven_day_weather array is #{nf2[1]}", "\n"

    pop = nf.pop
    print "First element of pop array is #{pop[0]}", "\n"
    print "Last element of pop array is #{pop[28]}", "\n"

    pt = ProjectLocalTime::format(Date.today)
    time = Array.new(28, pt)
    time.each_with_index do |str, idx|
      puts "#{str} and #{time[idx+1]}"
    end

    nf.get_forecast_array.should == [
      { :date => ProjectLocalTime::format(Date.today), :weather => pop[0] },
      { :date => ProjectLocalTime::format(Date.today + 6.hours), :weather => pop[1] }
      ]
  end
end
