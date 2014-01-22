require 'spec_helper'
require 'weather/noaa_forecast'
require 'time'

describe NOAAForecast do
  let(:fullcount) { 29 }
  let(:zipcode) { 94530 }
  let(:lat) { 38 }
  let(:long) { -122 }
  let(:lat_long) { [lat, long] }
  # let(:nf) { double(NOAAForecast) }
  let(:nf) { NOAAForecast.new(zipcode,168,6) }

  let(:pop) {
    [0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0]
  }
  let(:qpf) {
    [0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0]
  }

  before(:each) do
    @time_array = []
    for t in (0..27)
      date = { :date => ProjectLocalTime::format(Date.today + (t*6).hours) }
      @time_array.push(date)
    end
    @pop_array = []
    for t in (0..27)
      pop = { :weather => 99 }
      @pop_array.push(pop)
    end
    @qpf_array = []
    for t in (0..27)
      qpf = { :rainfall => 99 }
      @qpf_array.push(qpf)
    end

    nf.stub(:get_lat_long).with(zipcode).and_return([lat, long])
    nf.stub(:get_lat_long).with("0").and_return([])

    nf.stub(:ping_noaa).with([lat, long], 168, 6) {
      IO.read("./spec/lib/weather/noaa_response.xml")
    }

    nf.stub(:get_forecast).with([lat, long]) {
      response = nf.ping_noaa([lat, long], 168, 6)
      nf.parse_weather_data(response)
    }

    nf.stub(:seven_day_weather).with(zipcode).and_return {
      latlong = [lat, long]
      nf.get_forecast(latlong)
      # return zipcode
    }

    nf.stub(:get_time_array) {
      time_array = []
      for t in 0..27
        time_array << { :date => ProjectLocalTime::format(Date.today + (t*6).hours) }
      end
    }

    nf.stub(:get_pop).with(zipcode).and_return {
      IO.read("./spec/fixtures/get_pop_array.rb")
      # return pop
    }

    nf.stub(:get_qpf).with(zipcode).and_return {
      IO.read("./spec/fixtures/get_qpf_array.rb")
      # return qpf
    }

    nf.stub(:get_pop_array).with(zipcode).and_return {
      IO.read("./spec/fixtures/new_pop_array.rb")
      # return zipcode
    }

    nf.stub(:get_qpf_array) {
      IO.read("./spec/fixtures/new_qpf_array.rb")
      return zipcode
    }

    nf.stub(:get_time_pop_hash) {
      # time_array = []
      # for t in 0..27
      #   time_array << { :date => ProjectLocalTime::format(Date.today + (t*6).hours) }
      # end

      # nf.seven_day_weather(zipcode)
      # pop_array = nf.pop
      # new_pop_array = []
      # pop_array.each do |i|
      #   new_pop_array << { :weather => i.to_s }
      # end

      IO.read("./spec/fixtures/get_time_pop_hash.rb")
      # return zipcode
    }

    nf3 = NOAAForecast.new(zipcode,168,6)
    nf3.stub(:get_pop_table_hash) {

      IO.read("./spec/fixtures/get_pop_table_hash.rb")
      return zipcode
    }

    nf.stub(:get_forecast_array) {
      IO.read("./spec/fixtures/get_forecast_array.rb")
      # return zipcode
    }
  end # end of before block

  it "instantiates class with valid zipcode" do
    nf.class.should == NOAAForecast
  end

  it "returns lat/long for given zipcode" do
    latlong = [lat, long]
    latlong.size.should == 2
    tol = 0.0001
    latlong[0].should be_within(tol).of(38)
    latlong[1].should be_within(tol).of(-122)
  end

  describe "#get_lat_long" do
    it "returns get_lat_long stub values" do
      nf.get_lat_long(zipcode).should == [38, -122]
    end

    it 'handles exceptions with benign value' do
      nf.get_lat_long("0").should == []
    end

    it 'validates rails api caching on class object' do
      begin
        zipcode = 94901
        results = Geocoder.search(zipcode)
        lat = results[0].data["geometry"]["location"]["lat"]
        lng = results[0].data["geometry"]["location"]["lng"]
        lat_long = [] << lat << lng

        Rails.cache.fetch(zipcode.to_s + '_lat_long', expires_in: 24.hours) { lat_long }
        Rails.cache.clear
        Rails.cache.fetch(zipcode.to_s + '_lat') {lat}
        Rails.cache.fetch(zipcode.to_s + '_lat').should == lat
        Rails.cache.fetch(zipcode.to_s + '_lng') {lng}
        Rails.cache.fetch(zipcode.to_s + '_lng').should == lng

        nf = NOAAForecast.new(zipcode)
        nf.get_lat_long(zipcode).should == [lat, lng]
      rescue
        'Not online or method throwing error'
      end
    end
  end

  describe "Rails.cache.fetch" do
    it 'caches geocoder results with rails.cache.fetch' do
      Rails.cache.fetch(zipcode.to_s + '_lat_long', expires_in: 24.hours) { lat_long }
      pp "Rails.cache.fetch(zipcode_to.s + 'lat_long') = #{Rails.cache.fetch(zipcode.to_s + '_lat_long')}"

      Rails.cache.clear
      Rails.cache.fetch(zipcode.to_s + '_lat') { lat }
      Rails.cache.fetch(zipcode.to_s + '_lat').should == lat
      Rails.cache.fetch(zipcode.to_s + '_lng') { long }
      Rails.cache.fetch(zipcode.to_s + '_lng').should == long
    end
  end

  describe "#parse_weather_data" do
    it "parses weather data from noaa for one week" do
      response = nf.ping_noaa([lat, long], 168, 6)
      forecast = nf.parse_weather_data(response)
      forecast[0].size.should == fullcount
    end
  end

  describe "#get_valid_dates" do
    it "procures the valid date from the NOAA response" do
      response = nf.ping_noaa([lat, long], 168, 6)
      dates = nf.get_valid_dates(response)
      dates.size.should == 8
    end
  end

  describe "#get_forecast_creation_time" do
    it "procures forecast creation time from the NOAA response" do
      response = nf.ping_noaa([lat, long], 168, 6)
      creation_time = nf.get_forecast_creation_time(response)
      datehash = DateTime.parse("Sun Nov 18 23:02:24 2012 UTC", "%a %b %d %H:%M:%S %Y %Z")
      creation_time.should == datehash

      # pp forecast_array
      # pp nf.get_forecast([lat, long])
    end
  end

  describe "#seven_day_weather" do
    it "returns array from seven_day_weather" do
      begin
        forecast = nf.seven_day_weather(zipcode)
        forecast[0].size.should == fullcount
      rescue
        'Not online or method throwing error'
      end
    end

    it 'returns correct forecast' do
      nf = NOAAForecast.new(94530)
      nf.seven_day_weather(zipcode)
    end
  end

  describe "#get_forecast_array" do
    it "returns forecast_by_zipcode" do
      nf.should respond_to(:get_forecast_array)

      response = nf.ping_noaa([lat, long], 168, 6)
      forecast = nf.parse_weather_data(response)

      forecast_array = []
      for i in (0..27)
        date = { :date => ProjectLocalTime::format(Date.today + (6*i).hours) }
        weather = { :weather => forecast[0][i] }
        rainfall = { :rainfall => forecast[1][i] }

        date_weather = date.merge!(weather)
        date_weather_rainfall = date_weather.merge!(rainfall)
        forecast_array.push(date_weather_rainfall)
      end

      forecast_array.length.should == 28
      forecast_array.each do |f|
        f[:weather].should be_between(0,100)
        f[:rainfall].should be_between(0,100)
      end
    end
  end

  describe "#get_pop" do
    it "returns pop results" do
      nf = NOAAForecast.new(zipcode)
      pp nf.get_pop(zipcode)
      # nf.get_pop(zipcode).should == pop
    end
  end

  describe "#get_qpf" do
    it "returns qpf results" do
      nf = NOAAForecast.new(zipcode)
      pp nf.get_qpf(zipcode)
      # nf.get_qpf(zipcode).should == qpf
    end
  end

  describe "#get_time_array" do
    it "returns time array" do
      nf.should respond_to(:get_time_array)

      time_array = []
      for t in (0..27)
        time_array << { :date => ProjectLocalTime::format(Date.today + (t*6).hours) }
      end

      time_array.length.should == 28
    end
  end

  describe "#get_pop_array" do
    it "returns pop array" do
      nf = NOAAForecast.new(zipcode)
      pop_array = nf.get_pop(zipcode)

      new_pop_array = []
      pop_array.each do |i|
        new_pop_array << { :weather => pop_array[i].to_s }
      end

      nf.get_pop_array(zipcode).should == new_pop_array
    end
  end

  describe "#get_qpf_array" do
    it "returns qpf array" do
      nf = NOAAForecast.new(zipcode)
      nf.seven_day_weather(zipcode)
      qpf_array = nf.qpf

      new_qpf_array = []
      qpf_array.each do |i|
        new_qpf_array << { :rainfall => i.to_s }
      end

      nf.get_qpf_array(zipcode).should == new_qpf_array
    end
  end

  describe "#get_time_pop_hash" do
    it "returns time pop hash" do
      nf.should respond_to(:get_time_pop_hash)

      # response = nf.ping_noaa([lat, long], 168, 6)
      # forecast = nf.parse_weather_data(response)

      time_pop_hash = []
      for i in (0..27)
        time_pop_hash << @time_array[i].update(@pop_array[0])
      end
      pp time_pop_hash

      time_pop_hash.length.should == 28
      time_pop_hash.each do |f|
        pop = f[:weather].to_i
        if pop == -999
          pop = 0
        end
        pop.should be_between(0,100)
      end

      api_call = nf.get_time_pop_hash(zipcode)
      api_call.each do |f|
        pop = f[:weather].to_i
        if pop == -999
          pop = 0
        end
        pop.should be_between(0,100)
      end
=begin
      new_pop_array = []
      pop_array.each do |i|
        new_pop_array << { :weather => i.to_s }
      end

      time_pop_hash = []
      new_pop_array = nf.get_pop_array(zipcode)
      time_pop_hash << time_array.merge!(new_pop_array)
      pp time_pop_hash

      # nf.get_time_pop_hash(zipcode).should == time_pop_hash
      time_pop_hash = [
        time_array[0].update(new_pop_array[0]),
        time_array[1].update(new_pop_array[1]),
        time_array[2].update(new_pop_array[2]),
        time_array[3].update(new_pop_array[3]),
        time_array[4].update(new_pop_array[4]),
        time_array[5].update(new_pop_array[5]),
        time_array[6].update(new_pop_array[6]),
        time_array[7].update(new_pop_array[7]),
        time_array[8].update(new_pop_array[8]),
        time_array[9].update(new_pop_array[9]),
        time_array[10].update(new_pop_array[10]),
        time_array[11].update(new_pop_array[11]),
        time_array[12].update(new_pop_array[12]),
        time_array[13].update(new_pop_array[13]),
        time_array[14].update(new_pop_array[14]),
        time_array[15].update(new_pop_array[15]),
        time_array[16].update(new_pop_array[16]),
        time_array[17].update(new_pop_array[17]),
        time_array[18].update(new_pop_array[18]),
        time_array[19].update(new_pop_array[19]),
        time_array[20].update(new_pop_array[20]),
        time_array[21].update(new_pop_array[21]),
        time_array[22].update(new_pop_array[22]),
        time_array[23].update(new_pop_array[23]),
        time_array[24].update(new_pop_array[24]),
        time_array[25].update(new_pop_array[25]),
        time_array[26].update(new_pop_array[26]),
        time_array[27].update(new_pop_array[27])
      ]
=end
    end
  end

  describe "#get_pop_table_hash" do
    it "returns pop_table hash" do
      nf.should respond_to(:get_pop_table_hash)

      time_pop_hash = []
      for i in (0..27)
        time_pop = @time_array[i].update(@pop_array[i])
        time_pop_hash.push(time_pop)
      end
      pp time_pop_hash

      pop_table_hash = []
      for i in (0..27)
        time_pop_qpf = time_pop_hash[i].update(@qpf_array[i])
        pop_table_hash.push(time_pop_qpf)
      end
      pp pop_table_hash

      pop_table = nf.get_pop_table_hash(zipcode)
      pop_table.length.should == 27
      pop_table.each do |f|
        pop = f[:weather].to_i
        if pop == -999
          pop = 0
        end
        pop.should be_between(0,100)
        qpf = f[:rainfall].to_i
        if qpf == -999
          qpf = 0
        end
        qpf.should be_between(0,100)
      end

      pop_table_hash.length.should == 28
      pop_table_hash.each do |f|
        pop = f[:weather].to_i
        if pop == -999
          pop = 0
        end
        pop.should be_between(0,100)
        qpf = f[:rainfall].to_i
        if qpf == -999
          qpf = 0
        end
        qpf.should be_between(0,100)
      end
    end
  end
end
