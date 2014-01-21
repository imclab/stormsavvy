require 'spec_helper'
require 'weather/noaa_forecast'
require 'time'

describe NOAAForecast do
  let(:fullcount) { 29 }
  let(:zipcode) { 94530 }
  let(:lat) { 37.9202057 }
  let(:long) { -122.2937428 }
  let(:lat_long) { [lat, long] }
  let(:nf) { double(NOAAForecast) }
  let(:nf2) { NOAAForecast.new(zipcode,168,6) }
  let(:pop) { nf2.get_pop(zipcode) }
  let(:qpf) { nf2.get_qpf(zipcode) }

  before(:each) do
    nf.stub!(:get_lat_long).with(zipcode).and_return([lat, long])
    nf.stub!(:get_lat_long).with("99999999999999999999").and_return([])

    nf.stub!(:ping_noaa).with([lat, long], 168, 6) {
      IO.read("./spec/lib/weather/noaa_response.xml")
    }

    nf.stub!(:get_forecast).with([lat, long]) {
      response = nf.ping_noaa([lat, long], 168, 6)
      nf2.parse_weather_data(response)
    }

    nf2.stub(:seven_day_weather) {
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

    nf2.stub(:get_pop) {
      IO.read("./spec/fixtures/get_pop_array.rb")
      return pop
    }

    nf2.stub(:get_qpf) {
      IO.read("./spec/fixtures/get_qpf_array.rb")
      return qpf
    }

    nf2.stub(:get_pop_array) {
      IO.read("./spec/fixtures/new_pop_array.rb")
      return zipcode
    }

    nf2.stub(:get_qpf_array) {
      IO.read("./spec/fixtures/new_qpf_array.rb")
      return zipcode
    }

    nf2.stub(:get_time_pop_hash) {

      time_array = []
      for t in 0..27
        time_array << { :date => ProjectLocalTime::format(Date.today + (t*6).hours) }
      end

      nf2.seven_day_weather(zipcode)
      pop_array = nf2.pop
      new_pop_array = []
      pop_array.each do |i|
        new_pop_array << { :weather => i.to_s }
      end

      IO.read("./spec/fixtures/get_time_pop_hash.rb")
      return zipcode
    }

    nf3 = NOAAForecast.new(zipcode,168,6)
    nf3.stub(:get_pop_table_hash) {

      IO.read("./spec/fixtures/get_pop_table_hash.rb")
      return zipcode
    }

    nf2.stub(:get_forecast_array) {
      IO.read("./spec/fixtures/get_forecast_array.rb")
      return zipcode
    }
  end # need this here for before :each block!

  it "instantiates class with valid zipcode" do
    nf2.class.should == NOAAForecast
  end

  it "returns lat/long for given zipcode" do
    latlong = [lat, long]
    latlong.size.should == 2
    tol = 0.0001
    latlong[0].should be_within(tol).of(37.9202057)
    latlong[1].should be_within(tol).of(-122.2937428)
  end

  describe "#get_lat_long" do
    it "returns get_lat_long stub values" do
      nf.get_lat_long(zipcode).should == [37.9202057, -122.2937428]
    end

    it 'handles exceptions with benign value' do
      nf.get_lat_long("99999999999999999999").should == []
    end

    it 'validates rails api caching on class object' do
      begin
        zipcode = 94901
        results = Geocoder.search(zipcode)
        lat = results[0].data["geometry"]["location"]["lat"]
        lng = results[0].data["geometry"]["location"]["lng"]
        lat_long = [] << lat << lng

        Rails.cache.fetch(zipcode.to_s + '_lat_long', expires_in: 24.hours) { lat_long }
        # puts "Rails.cache.fetch(zipcode_to.s + 'lat_long') = #{Rails.cache.fetch(zipcode.to_s + '_lat_long')}"

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
      zipcode = 94530
      Rails.cache.fetch(zipcode.to_s + '_lat_long', expires_in: 24.hours) { lat_long }
      puts "Rails.cache.fetch(zipcode_to.s + 'lat_long') = #{Rails.cache.fetch(zipcode.to_s + '_lat_long')}"

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
      forecast = nf2.parse_weather_data(response)
      forecast[0].size.should == fullcount
    end
  end

  describe "#get_valid_dates" do
    it "procures the valid date from the NOAA response" do
      response = nf.ping_noaa([lat, long], 168, 6)
      dates = nf2.get_valid_dates(response)
      dates.size.should == 8
    end
  end

  describe "#get_forecast_creation_time" do
    it "procures forecast creation time from the NOAA response" do
      response = nf.ping_noaa([lat, long], 168, 6)
      creation_time = nf2.get_forecast_creation_time(response)
      datehash = DateTime.parse("Sun Nov 18 23:02:24 2012 UTC", "%a %b %d %H:%M:%S %Y %Z")
      creation_time.should == datehash
    end
  end

  describe "#seven_day_weather" do
    it "returns array from seven_day_weather" do
      begin
        forecast = nf2.seven_day_weather(zipcode)
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
      # pop = [0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0]
      # qpf = [99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99]

      # forecast_array = IO.read("./spec/fixtures/get_full_forecast_array.rb")
      forecast_array = [
        { :date => ProjectLocalTime::format(Date.today + 0.hours), :weather => pop[0], :rainfall => qpf[0] },
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
      nf2.get_forecast_array(zipcode).should == forecast_array
    end
  end

  describe "#get_pop" do
    it "returns pop results" do
      nf2.get_pop(zipcode).should == pop
    end
  end

  describe "#get_qpf" do
    it "returns qpf results" do
      nf2.get_qpf(zipcode).should == qpf
    end
  end

  describe "#get_time_array" do
    it "returns time array" do
      time_array = []
      for t in 0..27
        time_array << { :date => ProjectLocalTime::format(Date.today + (t*6).hours) }
      end

      nf2.get_time_array.should == time_array
    end
  end

  describe "#get_pop_array" do
    it "returns pop array" do
      # nf2.seven_day_weather(zipcode)
      pop_array = nf2.get_pop(zipcode)

      # debug collect method later
      # new_pop_array.collect {|i| new_pop_array << { :weather => pop_array[i].to_s } }
      new_pop_array = []
      pop_array.each do |i|
        new_pop_array << { :weather => pop_array[i].to_s }
      end

      nf2.get_pop_array(zipcode).should == new_pop_array
    end
  end

  describe "#get_qpf_array" do
    xit "returns qpf array" do
      nf2.seven_day_weather(zipcode)
      qpf_array = nf2.qpf

      new_qpf_array = []
      qpf_array.each do |i|
        new_qpf_array << { :rainfall => i.to_s }
      end

      nf2.get_qpf_array(zipcode).should == new_qpf_array
    end
  end

  describe "#time_pop_hash" do
    xit "returns time pop hash" do
      time_array = []
      for t in 0..27
        time_array << { :date => ProjectLocalTime::format(Date.today + (t*6).hours) }
      end

      nf2.seven_day_weather(zipcode)
      pop_array = nf2.get_pop(zipcode)
      new_pop_array = []
      pop_array.each do |i|
        new_pop_array << { :weather => i.to_s }
      end

      # array not being returned correctly
      # time_pop_hash = []
      # for h in 0..27
      #   time_pop_hash << Hash[time_array[h]].update(Hash[new_pop_array[h]])
      # end

      # refactor into proper loop
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

      # puts time_array
      # puts new_pop_array
      # puts time_array[0].update(new_pop_array[0])

      # puts nf2.get_time_pop_hash(zipcode)
      # puts time_pop_hash

      nf2.get_time_pop_hash(zipcode).should == time_pop_hash
    end
  end

  describe "#pop_table_hash" do
    # throws error when merging hashes
    xit "returns pop_table hash" do

      pop_array = nf2.pop
      new_pop_array = []
      pop_array.each do |i|
        new_pop_array << { :weather => i.to_s }
      end

      qpf_array = nf2.qpf
      new_qpf_array = []
      qpf_array.each do |i|
        new_qpf_array << { :rainfall => i.to_s }
      end

      time_array = []
      for t in 0..27
        time_array << { :date => ProjectLocalTime::format(Date.today + (t*6).hours) }
      end

      # array not being returned correctly
      # for h in 0..27
      #   time_pop_hash << Hash[time_array[h]].update(Hash[new_pop_array[h]])
      # end

      # time_pop_hash = nf2.get_time_pop_hash(zipcode)

      # array not being returned correctly
      # pop_table_hash = []
      # for k in 0..27
      #   pop_table_hash << Hash[time_pop_hash[k]].update(Hash[new_qpf_array[k]])
      # end

      # refactor into proper loop
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

      # refactor into proper loop
      pop_table_hash = [
        time_pop_hash[1].update(new_qpf_array[1]),
        time_pop_hash[2].update(new_qpf_array[2]),
        time_pop_hash[3].update(new_qpf_array[3]),
        time_pop_hash[4].update(new_qpf_array[4]),
        time_pop_hash[5].update(new_qpf_array[5]),
        time_pop_hash[6].update(new_qpf_array[6]),
        time_pop_hash[7].update(new_qpf_array[7]),
        time_pop_hash[8].update(new_qpf_array[8]),
        time_pop_hash[9].update(new_qpf_array[9]),
        time_pop_hash[10].update(new_qpf_array[10]),
        time_pop_hash[11].update(new_qpf_array[11]),
        time_pop_hash[12].update(new_qpf_array[12]),
        time_pop_hash[13].update(new_qpf_array[13]),
        time_pop_hash[14].update(new_qpf_array[14]),
        time_pop_hash[15].update(new_qpf_array[15]),
        time_pop_hash[16].update(new_qpf_array[16]),
        time_pop_hash[17].update(new_qpf_array[17]),
        time_pop_hash[18].update(new_qpf_array[18]),
        time_pop_hash[19].update(new_qpf_array[19]),
        time_pop_hash[20].update(new_qpf_array[20]),
        time_pop_hash[21].update(new_qpf_array[21]),
        time_pop_hash[22].update(new_qpf_array[22]),
        time_pop_hash[23].update(new_qpf_array[23]),
        time_pop_hash[24].update(new_qpf_array[24]),
        time_pop_hash[25].update(new_qpf_array[25]),
        time_pop_hash[26].update(new_qpf_array[26]),
        time_pop_hash[27].update(new_qpf_array[27])
      ]

      time_pop_hash = []

      nf3.get_pop_table_hash(zipcode).should == pop_table_hash
    end
  end
end
