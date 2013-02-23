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

    @fe = double(ForecastExaminer)
    # @nf.stub(:get_lat_long).with(@zipcode).and_return([@lat, @long])

    # @nf.stub(:set_lat_long) do
    #   $redis.set(@zipcode.to_s + '_lat', @lat)
    #   $redis.set(@zipcode.to_s + '_long', @long)
    # end
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

  end
end
