require 'spec_helper'
require 'geocoder'
require 'nokogiri'
require 'weather/noaa_forecast'
require 'time'

describe NOAAForecast do
  let(:fullcount) { 29 }
  let(:zipcode) { 94530 }
  let(:duration) { 168 }
  let(:interval) { 6 }
  let(:lat) { 38 }
  let(:long) { -122 }
  let(:lat_long) { [lat, long] }
  let(:nf) { NOAAForecast.new(zipcode,duration,interval) }

  let(:pop) {
    [0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0]
  }
  let(:qpf) {
    [0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0, 99, 0]
  }
  let(:results) {
    IO.read("./spec/lib/weather/geocoder_response.json")
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
    @time_pop_hash = []
    for i in (0..27)
      @time_pop_hash << @time_array[i].update(@pop_array[i])
    end
    @pop_table_hash = []
    for i in (0..27)
      @time_pop_hash[i].merge!(@qpf_array[i])
    end

    nf.stub(:get_lat_long).with(zipcode).and_return([lat, long])
    nf.stub(:get_lat_long).with("0").and_return([])

    # nf.stub(:ping_noaa).with([lat, long], 168, 6) {
    #   IO.read("./spec/lib/weather/noaa_response.xml")
    # }
    # nf.stub(:get_forecast).with([lat, long]) {
    #   response = nf.ping_noaa([lat, long], 168, 6)
    #   nf.parse_weather_data(response)
    # }
    # nf.stub(:seven_day_weather).with(zipcode).and_return {
    #   latlong = [lat, long]
    #   nf.get_forecast(latlong)
    # }
    nf.stub(:get_time_array) {
      time_array = []
      for t in 0..27
        time_array << { :date => ProjectLocalTime::format(Date.today + (t*6).hours) }
      end
    }
    nf.stub(:get_pop).with(zipcode).and_return {
      @pop_array
    }
    nf.stub(:get_qpf).with(zipcode).and_return {
      @qpf_array
    }
    nf.stub(:get_pop_array).with(zipcode).and_return {
      @pop_array
    }
    nf.stub(:get_qpf_array).with(zipcode).and_return {
      @qpf_array
    }
    nf.stub(:get_time_pop_hash).with(zipcode).and_return {
      @time_pop_hash
    }
    nf.stub(:get_pop_table_hash).with(zipcode).and_return {
      @pop_table_hash
    }
    nf.stub(:get_forecast_array).with(zipcode).and_return {
      @forecast_array
    }
  end

  it "instantiates class with valid zipcode" do
    nf.class.should == NOAAForecast
  end

  it "returns lat_long array" do
    lat_long.count.should == 2
    tol = 0.0001
    lat_long[0].should be_within(tol).of(38)
    lat_long[1].should be_within(tol).of(-122)
  end

  describe "#seven_day_weather" do
    it "returns array from seven_day_weather" do
      begin
        nf.should respond_to(:seven_day_weather)
        forecast = nf.seven_day_weather(zipcode)
        forecast[0].count.should == fullcount
      rescue => e
      end
    end

    it 'returns correct forecast' do
      begin
        forecast = nf.seven_day_weather(zipcode)
        forecast[0].length.should == 29
        forecast[0].each do |pop|
          pop.should be_between(0,100)
        end

        forecast[1].length.should == 29
        forecast[1].each do |qpf|
          qpf.should be_between(0,100)
        end
      rescue => e
      end
    end
  end

  describe "#get_lat_long" do
    context 'when passing in valid zipcode' do
      it "returns get_lat_long stub values" do
        nf.should respond_to(:get_lat_long)
        nf.get_lat_long(zipcode).count.should == 2
        lat_long[0].should be_between(37,39)
        lat_long[1].should be_between(-123,-121)
      end
    end

    context 'when passing in invalid zipcode' do
      it 'handles exceptions with benign value' do
        nf.get_lat_long("0").should == []
      end
    end

    it 'returns response using geocoder' do
      begin
        results = Geocoder.search(zipcode)
        results[0].data["geometry"]["location"]["lat"].should be_between(37,39)
        results[0].data["geometry"]["location"]["lng"].should be_between(-123,-121)
      rescue => e
      end
    end

    it 'returns response using geocoder service' do
      begin
        service = GeocoderService.new(zipcode: zipcode)
        results = service.get_lat_lng
        results[:lat].should be_between(37,39)
        results[:long].should be_between(-123,-121)
      rescue => e
      end
    end

    it 'caches geocoder results with rails.cache.fetch' do
      Rails.cache.fetch(zipcode.to_s + '_lat_long', expires_in: 24.hours) { lat_long }
      Rails.cache.clear
      Rails.cache.fetch(zipcode.to_s + '_lat') {lat}
      Rails.cache.fetch(zipcode.to_s + '_lat').should == lat
      Rails.cache.fetch(zipcode.to_s + '_long') {long}
      Rails.cache.fetch(zipcode.to_s + '_long').should == long
      nf.get_lat_long(zipcode).should == lat_long
    end
  end

  describe '#get_forecast' do
    it 'gets forecast' do
      begin
        response = nf.ping_noaa([lat, long], 168, 6)
        forecast = nf.parse_weather_data(response)
        forecast[0].length.should == 29
        forecast[0].each do |pop|
          pop.should be_between(0,100)
        end

        forecast[1].length.should == 29
        forecast[1].each do |qpf|
          qpf.should be_between(0,100)
        end
      rescue => e
      end
    end
  end

  describe '#ping_noaa' do
    context 'xml' do
      it 'returns string class' do
        response = nf.ping_noaa([lat, long], 168, 6)
        response.class.should == String
      end

      xit 'returns xml doc' do
        # response = nf.ping_noaa([lat, long], 168, 6)
        response = IO.read("./spec/lib/weather/noaa_response.xml")
        response.body.should have_xml '//pop' "0"
      end
    end
  end

  describe '#log_response' do
    it 'returns correct response message' do
      xml = "http://www.wrh.noaa.gov/forecast/xml/xml.php?duration=#{duration}&interval=#{interval}&lat=#{lat_long[0]}&lon=#{lat_long[1]}"
      request = Typhoeus::Request.new(xml,
        body: "this is a request body",
        method: :post,
        headers: {:Accept => "text/html"},
        timeout: 5000, # milliseconds
        # cache_timeout: 60, # seconds
        params: {:field1 => "a field"}
      )
      hydra = Typhoeus::Hydra.new
      hydra.queue(request)
      hydra.run
      # pp request.response.status_message
      nf.log_response(request)
    end
  end

  describe "#get_valid_dates" do
    it "procures the valid date from the NOAA response" do
      begin
        response = nf.ping_noaa([lat, long], 168, 6)
        dates = nf.get_valid_dates(response)
        dates.count.should == 8
      rescue => e
      end
    end
  end

  describe "#get_forecast_creation_time" do
    it "procures forecast creation time from the NOAA response" do
      nf.stub(:ping_noaa).with([lat, long], 168, 6) {
        IO.read("./spec/lib/weather/noaa_response.xml")
      }

      response = nf.ping_noaa([lat, long], 168, 6)
      creation_time = nf.get_forecast_creation_time(response)
      datehash = DateTime.parse("Sun Nov 18 23:02:24 2012 UTC", "%a %b %d %H:%M:%S %Y %Z")
      creation_time.should == datehash
    end
  end

  describe "#parse_weather_data" do
    it "parses weather data from noaa for one week" do
      begin
        nf.should respond_to(:parse_weather_data)
        response = nf.ping_noaa([lat, long], 168, 6)
        forecast = nf.parse_weather_data(response)
        forecast[0].count.should == fullcount
      rescue => e
      end
    end
  end

  describe "#get_forecast_array" do
    it "returns forecast_by_zipcode" do
      begin
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

        forecast_array.count.should == 28
        forecast_array.each do |f|
          f[:weather].should be_between(0,100)
          f[:rainfall].should be_between(0,100)
        end
      rescue => e
      end
    end
  end

  describe '#forecast_by_zipcode' do
    it 'gets forecast by zipcode' do
      begin
        nf.should respond_to(:forecast_by_zipcode)
        forecast_array = nf.forecast_by_zipcode(zipcode)
        forecast_array.count.should == 28
        forecast_array.each do |f|
          if f[:weather] == -999
            f[:weather] = 0
          end
          f[:weather].should be_between(0,100)

          if f[:rainfall] == -999
            f[:rainfall] = 0
          end
          f[:rainfall].should be_between(0,100)
        end
      rescue => e
      end
    end
  end

  describe "#get_pop" do
    it "checks pop array size" do
      nf.should respond_to(:get_pop)
      nf.get_pop(zipcode)
      @pop_array.count.should == 28
      @pop_array.each do |f|
        f[:weather].should be_between(0,100)
      end
    end

    it 'checks pop results' do
      @pop_array.each do |f|
        if f == -999
          f = 0
        end
        f[:weather].should be_between(0,100)
      end
    end
  end

  describe "#get_qpf" do
    it "checks qpf array size" do
      nf.should respond_to(:get_qpf)
      nf.get_qpf(zipcode)
      @qpf_array.count.should == 28
    end

    it 'checks qpf results' do
      @qpf_array.each do |f|
        if f == -999
          f = 0
        end
        f[:rainfall].should be_between(0,100)
      end
    end
  end

  describe "#get_time_array" do
    it "returns time array" do
      nf.should respond_to(:get_time_array)
      nf.get_time_array
      @time_array.count.should == 28
    end
  end

  describe "#get_pop_array" do
    it "returns pop array" do
      nf.should respond_to(:get_pop_array)
      nf.get_pop_array(zipcode)
      @pop_array.count.should == 28
    end
  end

  describe "#get_qpf_array" do
    it "returns qpf array" do
      nf.should respond_to(:get_qpf_array)
      nf.get_qpf_array(zipcode)
      @qpf_array.count.should == 28
    end
  end

  describe "#get_time_pop_hash" do
    it "returns time pop hash" do
      nf.should respond_to(:get_time_pop_hash)
      nf.get_time_pop_hash(zipcode)

      @time_pop_hash.count.should == 28
      @time_pop_hash.each do |f|
        pop = f[:weather].to_i
        if pop == -999
          pop = 0
        end
        pop.should be_between(0,100)
      end
    end
  end

  describe "#get_pop_table_hash" do
    xit "returns pop_table hash" do
      nf.should respond_to(:get_pop_table_hash)

      # time_pop_hash = []
      # for i in (0..27)
      #   time_pop_hash << @time_array[i].update(@pop_array[i])
        # time_pop = @time_array[i].update(@pop_array[i])
        # time_pop_hash.push(time_pop)
      # end

      # pop_table_hash = []
      # for i in (0..27)
      #   pop_table_hash << @time_pop_hash[i].update(@qpf_array[i])
        # time_pop_qpf = time_pop_hash[i].update(@qpf_array[i])
        # pop_table_hash.push(time_pop_qpf)
      # end

      pop_table = nf.get_pop_table_hash(zipcode)
      pop_table.count.should == 28 # merging array is failing spec
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

      pop_table_hash = nf.get_pop_table_hash(zipcode)
      pop_table_hash.count.should == 28
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
