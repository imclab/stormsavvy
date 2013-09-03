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

    @site = FactoryGirl.create(
      :site,
      :name => 'ec jungle gym'
    )

    @report = FactoryGirl.create(
      :report,
      :site => @site
      )
    @reports = [@report]

    @inspection_event = FactoryGirl.create(
      :inspection_event,
      :site => @site
      )
    @inspection_events = [@inspection_event]

    @sampling_event = FactoryGirl.create(
      :sampling_event,
      :site => @site
      )
    @sampling_events = [@sampling_event]

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
    @nf2.seven_day_weather

    @nf.stub(:ping_noaa).with([@lat, @long], 168, 6) do
      IO.read("./spec/lib/weather/noaa_response.xml")
    end

    @nf.stub(:get_forecast).with([@lat, @long]) do
      response = @nf.ping_noaa([@lat, @long], 168, 6)
      @nf2.parse_weather_data(response)
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

  describe "project associations" do
    before(:each) do
      @project = FactoryGirl.create(:project)
      @site = FactoryGirl.create(:site)
    end

   it "creates new instance of given valid attributes" do
      @project.sites.create!(
        :name    => "Oakland Adams Point",
        :city    => "Oakland",
        :zipcode => 94610
        )
      @project.sites.first.should be_valid
    end

    # TDD for handling belongs_to
    it "should have a project attribute" do
      @site.should respond_to(:project)
    end
  end

  describe 'report associations' do
    it 'responds to reports' do
      @site.should respond_to(:reports)
    end

    it 'has projects in correct order' do
      @site.reports.should == @reports
    end

    it 'destroys associated sites' do
      @site.destroy
      @reports.each do |report|
        Report.find_by_id(report.id).should be_nil
      end
    end
  end

  describe 'inspection_event associations' do
    it 'responds to inspection_events' do
      @site.should respond_to(:inspection_events)
    end

    it 'has inspection events in correct order' do
      @site.inspection_events.should == @inspection_events
    end

    it 'destroys associated inspection events' do
      @site.destroy
      @inspection_events.each do |inspection_event|
        InspectionEvent.find_by_id(inspection_event.id).should be_nil
      end
    end
  end

  describe 'sampling_event associations' do
    it 'responds to sampling_events' do
      @site.should respond_to(:sampling_events)
    end

    it 'has sampling events in correct order' do
      @site.sampling_events.should == @sampling_events
    end

    it 'destroys associated sampling events' do
      @site.destroy
      @sampling_events.each do |sampling_event|
        SamplingEvent.find_by_id(sampling_event.id).should be_nil
      end
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

  describe '#chance_of_rain' do
    it 'returns chance of rain' do
      max_rain = @site.chance_of_rain
      max_rain.should be_between(0,100)
      max_rain.should >= 0
      max_rain.should <= 100
    end
  end

  describe '#forecast' do
=begin
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
=end
  end

  describe '#get_zipcode' do
    it 'returns zipcode' do
      @site.get_zipcode.should == @site.zipcode.to_s
    end
  end
end
