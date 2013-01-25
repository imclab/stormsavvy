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

  it "does something with seven day weather" do
    forecast = @nf.seven_day_weather
    forecast[0].size.should == @fullcount
  end

  it "returns get_forecast_array" do
    nf = NOAAForecast.new(94530,168,6)
    nf2 = nf.seven_day_weather
    pop = nf.pop

    print "Pop hash before map: #{pop}", "\n"
    pop.each do |i|
      print "Storm POP = #{pop[i]}", "\n"
    end

    nf.get_forecast_array.should == [
      { :date => ProjectLocalTime::format(Date.today), :weather => pop[0] },
      { :date => ProjectLocalTime::format(Date.today + 6.hours), :weather => pop[1] }
      ]

  end

  it "returns get_time_array" do
    nf = NOAAForecast.new(94530,168,6)
    pop = nf.pop

    pt = []
    pop.each_with_index do |(i, p), index|
      pt << { :date => ProjectLocalTime::format(Date.today + (index*6).hours), :weather => i.to_s }
    end
    print "pt array = #{pt}", "\n"

    nf.get_time_array.should == pt

=begin
    pt = []
    pop.each_with_index do |(i, p), index|
      pt << { ProjectLocalTime::format(Date.today + (index*6).hours) => i }
    end
    print "pt array = #{pt}", "\n"

    nf.get_time_array.should == pt
=end
  end
end
