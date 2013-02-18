require 'spec_helper'
require 'weather/noaa_forecast'
require 'redis'

describe NOAAForecast do

  before(:each) do
    @fullcount = 29
    @zipcode = 94530
    @zipcode2 = 94605
    @lat = 37.9202057
    @long = -122.2937428
    lat_long = [@lat, @long]
    @nf = double(NOAAForecast)

    @nf.stub(:get_lat_long).with(@zipcode).and_return([@lat, @long])

    @nf.stub(:set_lat_long) do
      $redis.set(@zipcode.to_s + '_lat', @lat)
      $redis.set(@zipcode.to_s + '_long', @long)
    end

    @nf.stub(:return_lat_long) do
      @nf.set_lat_long(@zipcode)
      lat = $redis.get(@zipcode.to_s + '_lat')
      long = $redis.get(@zipcode.to_s + '_long')
      lat_long = [lat, long]
    end

    @nf.stub(:ping_noaa).with([@lat, @long], 168, 6) do
      IO.read("./spec/lib/weather/noaa_response.xml")
    end

    @nf.stub(:get_forecast).with([@lat, @long]) do
      response = @nf.ping_noaa([@lat, @long], 168, 6)
      nf = NOAAForecast.new(94530)
      nf.parse_weather_data(response)
    end

    @nf.stub(:seven_day_weather) do
      latlong = [@lat, @long]
      @nf.get_forecast(latlong)
    end

    @nf.stub(:pop) do
      IO.read("./spec/lib/weather/pop_stub_data.txt")
    end

    # setup for forecast_array
    nf = NOAAForecast.new(@zipcode,168,6)
    nf.seven_day_weather
    pop = nf.pop
    qpf = nf.qpf # forecast rainfall returns null here
    @forecast_array = [
      { :date => ProjectLocalTime::format(Date.today), :weather => pop[0], :rainfall => qpf[0] },
      { :date => ProjectLocalTime::format(Date.today + 6.hours), :weather => pop[1], :rainfall => qpf[1] },
      { :date => ProjectLocalTime::format(Date.today + 12.hours), :weather => pop[2], :rainfall => qpf[2] },
      { :date => ProjectLocalTime::format(Date.today + 18.hours), :weather => pop[3], :rainfall => qpf[3] },
      { :date => ProjectLocalTime::format(Date.today + 24.hours), :weather => pop[4], :rainfall => qpf[4] },
      { :date => ProjectLocalTime::format(Date.today + 30.hours), :weather => pop[5], :rainfall => qpf[5] },
      { :date => ProjectLocalTime::format(Date.today + 36.hours), :weather => pop[6], :rainfall => qpf[6] },
      { :date => ProjectLocalTime::format(Date.today + 42.hours), :weather => pop[7], :rainfall => qpf[7] },
      { :date => ProjectLocalTime::format(Date.today + 48.hours), :weather => pop[8], :rainfall => qpf[8] },
      { :date => ProjectLocalTime::format(Date.today + 54.hours), :weather => pop[9], :rainfall => qpf[9] },
      { :date => ProjectLocalTime::format(Date.today + 60.hours), :weather => pop[10], :rainfall => qpf[10] },
      { :date => ProjectLocalTime::format(Date.today + 66.hours), :weather => pop[11], :rainfall => qpf[11] },
      { :date => ProjectLocalTime::format(Date.today + 72.hours), :weather => pop[12], :rainfall => qpf[12] },
      { :date => ProjectLocalTime::format(Date.today + 78.hours), :weather => pop[13], :rainfall => qpf[13] },
      { :date => ProjectLocalTime::format(Date.today + 84.hours), :weather => pop[14], :rainfall => qpf[14] },
      { :date => ProjectLocalTime::format(Date.today + 90.hours), :weather => pop[15], :rainfall => qpf[15] },
      { :date => ProjectLocalTime::format(Date.today + 96.hours), :weather => pop[16], :rainfall => qpf[16] },
      { :date => ProjectLocalTime::format(Date.today + 102.hours), :weather => pop[17], :rainfall => qpf[17] },
      { :date => ProjectLocalTime::format(Date.today + 108.hours), :weather => pop[18], :rainfall => qpf[18] },
      { :date => ProjectLocalTime::format(Date.today + 114.hours), :weather => pop[19], :rainfall => qpf[19] },
      { :date => ProjectLocalTime::format(Date.today + 120.hours), :weather => pop[20], :rainfall => qpf[20] },
      { :date => ProjectLocalTime::format(Date.today + 126.hours), :weather => pop[21], :rainfall => qpf[21] },
      { :date => ProjectLocalTime::format(Date.today + 132.hours), :weather => pop[22], :rainfall => qpf[22] },
      { :date => ProjectLocalTime::format(Date.today + 138.hours), :weather => pop[23], :rainfall => qpf[23] },
      { :date => ProjectLocalTime::format(Date.today + 144.hours), :weather => pop[24], :rainfall => qpf[24] },
      { :date => ProjectLocalTime::format(Date.today + 150.hours), :weather => pop[25], :rainfall => qpf[25] },
      { :date => ProjectLocalTime::format(Date.today + 156.hours), :weather => pop[26], :rainfall => qpf[26] },
      { :date => ProjectLocalTime::format(Date.today + 162.hours), :weather => pop[27], :rainfall => qpf[27] },
      { :date => ProjectLocalTime::format(Date.today + 168.hours), :weather => pop[28], :rainfall => qpf[28] }
      ]
  end

  it "instantiates class with valid zipcode" do
    nf = NOAAForecast.new(@zipcode)
    nf.class.should == NOAAForecast
  end

  it "returns lat/long for given zipcode" do
    latlong = [@lat, @long]
    latlong.size.should == 2
    tol = 0.0001
    latlong[0].should be_within(tol).of(37.9202057)
    latlong[1].should be_within(tol).of(-122.2937428)
  end

  describe "#get_lat_long" do
    it "returns get_lat_long stub values" do
      @nf.get_lat_long(@zipcode).should == [37.9202057, -122.2937428]
    end

    it "sets and gets lat/long with redis" do
      @nf.set_lat_long(@zipcode)
      lat = $redis.get(@zipcode.to_s + '_lat')
      long = $redis.get(@zipcode.to_s + '_long')
      lat_long = [lat.to_f, long.to_f]
      @nf.get_lat_long(@zipcode).should == lat_long
    end
  end

  describe "#parse_weather_data" do
    it "parses weather data from noaa for one week" do
      response = @nf.ping_noaa([@lat, @long], 168, 6)
      nf = NOAAForecast.new(@zipcode,168,6)
      forecast = nf.parse_weather_data(response)
      forecast[0].size.should == @fullcount
    end
  end

  describe "#get_valid_dates" do
    it "procures the 'validDate' from the NOAA response" do
      response = @nf.ping_noaa([@lat, @long], 168, 6)
      nf = NOAAForecast.new(@zipcode,168,6)
      dates = nf.get_valid_dates(response)
      dates.size.should == 8
    end
  end

  describe "#get_forecast_creation_time" do
    it "procures forecast creation time from the NOAA response" do
      response = @nf.ping_noaa([@lat, @long], 168, 6)
      nf = NOAAForecast.new(@zipcode,168,6)
      creation_time = nf.get_forecast_creation_time(response)
      datehash = DateTime.parse("Sun Nov 18 23:02:24 2012 UTC", "%a %b %d %H:%M:%S %Y %Z")
      creation_time.should == datehash
    end
  end

  describe "#seven_day_weather" do
    it "returns array from seven_day_weather" do
      forecast = @nf.seven_day_weather
      forecast[0].size.should == @fullcount
    end
  end

  describe "#get_forecast_array" do
    it "returns forecast_by_zipcode" do
      nf = NOAAForecast.new(@zipcode,168,6)
      nf.seven_day_weather
      pop = nf.pop
      nf.get_forecast_array.should == @forecast_array
    end
  end

  describe "#get_pt_hash" do
    it "returns pop table hash" do
      nf = NOAAForecast.new(94530,168,6)
      nf.seven_day_weather

      # collect time elements
      time_array = []
      for t in 0..27
        time_array << { :date => ProjectLocalTime::format(Date.today + (t*6).hours) }
        # new_pop_array << { :date => ProjectLocalTime::format(Date.today + (i*6).hours), :weather => i.to_s }
      end
      puts time_array

      # collect pop elements
      pop_array = nf.pop
      new_pop_array = []
      pop_array.each do |i|
        new_pop_array << { :weather => i.to_s }
        # new_pop_array << { :date => ProjectLocalTime::format(Date.today + (i*6).hours), :weather => i.to_s }
      end
      puts new_pop_array
      # nf.get_pt_hash.should == pt

      # collect rainfall elements
      qpf_array = nf.qpf
      new_qpf_array = []
      qpf_array.each do |i|
        new_qpf_array << { :rainfall => i.to_s }
      end
      puts new_qpf_array


      # pt3 = Hash[pt.zip(pt2)]
      puts pt3
    end
  end

  it "creates redis object" do
    $redis.class.should == Redis
  end

  it "stores lat/long values using $redis.set" do
    zipcode = @zipcode
    lat_long = [@lat, @long]
    $redis.set(zipcode.to_s + '_lat', lat_long[0])
    $redis.set(zipcode.to_s + '_long', lat_long[1])
    $redis.get(zipcode.to_s + '_lat').should == lat_long[0].to_s
    $redis.get(zipcode.to_s + '_long').should == lat_long[1].to_s
  end

  describe "#set_lat_long" do
    it "calls set_lat_long method successfully" do
      lat_long = [@lat, @long]
      @nf.set_lat_long(@zipcode)
      $redis.get(@zipcode.to_s + '_lat').should == lat_long[0].to_s
      $redis.get(@zipcode.to_s + '_long').should == lat_long[1].to_s
    end
  end

  describe "#return_lat_long" do
    it "calls return_lat_long method successfully" do
      lat = $redis.get(@zipcode.to_s + '_lat')
      long = $redis.get(@zipcode.to_s + '_long')
      results = [lat,long]
      @nf.set_lat_long(@zipcode)
      @nf.return_lat_long(@zipcode).should == results
    end
  end
end
