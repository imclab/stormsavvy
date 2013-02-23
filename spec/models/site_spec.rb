require 'spec_helper'
require 'weather/noaa_forecast'

describe Site do

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
  end

  describe "validations" do
    it "should have a name" do
      @site.name = ''
      @site.should_not be_valid
    end

    it "should have a zipcode" do
      @site.zipcode = @zipcode2
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

  describe '#forecast' do
    it 'returns site address' do
      
    end
  end

end
