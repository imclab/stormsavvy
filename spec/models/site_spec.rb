require 'spec_helper'
require 'weather/forecast_examiner'
require 'redis'

describe Site do

  before(:all) do
    @data = []
    CSV.foreach(Rails.root.to_s + '/spec/lib/weather/ss_fc_fixture.csv') do |row|
      @data << row
    end
    @data.delete_if { |r| r == [] }
  end

  before(:each) do
    @lat = 37.81164190000001
    @long = -122.255463
    @zipcode = 94610
    @zipcode2 = ''
    @latlong = [@lat, @long]
    @address = '111 Adams Street Suite 181 Oakland CA 94610'

    @site = FactoryGirl.create(:site)
    @site.stub(:lat) do
      lat = @lat
    end
    @site.stub(:long) do
      long = @long
    end
    @site.stub(:zipcode) do
      zipcode = @zipcode
    end

    lat_long = [@lat, @long]
    @nf = double(NOAAForecast)
    @nf2 = NOAAForecast.new(@zipcode,168,6)
    @nf2.seven_day_weather(@zipcode)
    @nf.stub(:ping_noaa).with([@lat, @long], 168, 6) do
      IO.read("./spec/lib/weather/noaa_response.xml")
    end

    @nf.stub(:get_forecast).with([@lat, @long]) do
      response = @nf.ping_noaa([@lat, @long], 168, 6)
      @nf2.parse_weather_data(response)
    end

    @nf.stub(:seven_day_weather) do
      latlong = [@lat, @long]
      @nf.get_forecast(latlong)
    end

    @site.stub(:forecast) do
      latlong = [@lat, @long]
      @nf.get_forecast(latlong)
    end
  end

  describe "validations" do
    it "should have a name" do
      @site.name = ''
      @site.should_not be_valid
    end
  end

  describe "associations" do
    before(:each) do
      @project = FactoryGirl.create(:project)
      @site = FactoryGirl.create(:site)
    end

   it "should create a new instance given valid attributes" do
      @project.sites.create!(
        :name    => "Oakland Adams Point",
        :city    => "Oakland",
        :zipcode => 94610
        )
      @project.sites.first.should be_valid
    end

    # TTD for handling belongs_to
    it "should have a project attribute" do
      @site.should respond_to(:project)
    end
  end

  describe "attributes" do

    before :each do
      @site = FactoryGirl.create(:site)
    end

    it 'has correct attributes' do
      @site.name.should == "Oakland Adams Point"
      @site.description.should == "North of Lake Merritt"
      @site.costcode.should == "450AZC"
      @site.size.should == "20 acres"
      @site.exposed_area.should == "10 acres"
      @site.address_1.should == '111 Adams Street'
      @site.address_2.should == 'Suite 181'
      @site.city.should == 'Oakland'
      @site.zipcode.should == 94610

      @site.should respond_to(:project)
    end
  end

  describe 'lat/long stub values' do 
    it "returns correct stub for oakland latlong" do
      @site.lat.round.should == 38
      @site.long.round.should == -122
    end
  end

  describe '#address' do
    it 'returns site address' do
      puts @site.address
      @site.address.should == @address
    end
  end

  describe '#precipitation_state' do
    it 'sets rain state to imminent' do
      forecast = [@data[6], @data[7]]
      @site.precipitation_state(forecast).should == :imminent
    end

    it 'sets rain state to warning' do
      forecast = [@data[8], @data[9]]
      @site.precipitation_state(forecast).should == :warning
    end

    it 'sets rain state to watch' do
      forecast = [@data[2], @data[3]]
      @site.precipitation_state(forecast).should == :watch
    end

    it 'sets rain state to clear' do
      forecast = [@data[0], @data[1]]
      @site.precipitation_state(forecast).should == :clear
    end
  end

  describe '#forecast' do
    it 'returns forecast' do
      latlong = [@lat, @long]
      forecast = @nf.get_forecast(latlong)
      @site.forecast.should == forecast
    end

    site = Site.create!(
      :name          => 'Oakland Adams Point',
      :address_1     => '111 Adams Street',
      :address_2     => 'Suite 181',
      :city          => 'Oakland',
      :state         => 'CA',
      :zipcode       => 94610,
      :description   => 'North of Lake Merritt'
      )
    forecast = site.forecast
    print forecast
  end

  describe '#get_zipcode' do
    it 'returns zipcode' do
      @site.get_zipcode.should == @site.zipcode.to_s
    end
  end
end
