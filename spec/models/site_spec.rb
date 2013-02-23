require 'spec_helper'

describe Site do

  before(:each) do
    @lat = 37.81164190000001
    @long = -122.255463
    @latlong = [@lat, @long]

    @site = FactoryGirl.create(:site)

    # @site2 = Site.create!(
    #   :name    => 'Oakland Adams Point',
    #   :address_1  => '111 Sesame Street',
    #   :address_2  => 'Suite 181',
    #   :city    => 'Oakland',
    #   :state      => 'CA',
    #   :zipcode => 94610
    #   )
    @site.stub(:lat) do
      lat = @lat
    end
    @site.stub(:long) do
      long = @long
    end
  end

  describe "validations" do

    it "should have a name" do
      @site.name = ''
      @site.should_not be_valid
    end

    it "should have a zipcode" do
      @site.zipcode = ''
      @site.should_not be_valid
    end
  end

  describe "associations" do

    before(:each) do
      @project = FactoryGirl.create(:project)
      @site = FactoryGirl.create(:site)
    end

   it "should create a new instance given valid attributes" do
      @project.sites.create!(:name    => "Oakland Adams Point",
                             :city    => "Oakland",
                             :zipcode => 94610)
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

    it "should have name" do
      @site.name.should == "Oakland Adams Point"
    end

    it "should have description" do
      @site.description.should == "North of Lake Merritt"
    end

    it "should have costcode" do
      @site.costcode.should == "450AZC"
    end

    it "should have size" do
      @site.size.should == "20 acres"
    end

    it "should have exposed_area" do
      @site.exposed_area.should == "10 acres"
    end

    it "should have zipcode" do
      @site.zipcode.should == 94610
    end

    it "should belong to project" do
      @site.should respond_to(:project)
    end
  end

  describe "geocoding feature" do 
    it "should geocode oakland" do
      # s = Site.create!(:name    => "Oakland Adams Point",
      #                  :city    => "Oakland",
      #                  :zipcode => 94610)
      @site.lat.round.should == 38
      @site.long.round.should == -122
    end
  end

  describe "#address" do
    it 'returns site address' do
      # site = Site.new(:address_1  => '111 Sesame Street',
      #                 :address_2  => 'Suite 181',
      #                 :city       => 'Gotham City',
      #                 :state      => 'NY',
      #                 :zipcode    => '90001')
      # site.address.should == '111 Sesame Street Suite 181 Gotham City NY 90001'
      puts @site2.address
    end
  end

  describe "#address" do
    it 'returns site address' do
      site = Site.new(:address_1  => '111 Sesame Street',
                      :address_2  => 'Suite 181',
                      :city       => 'Gotham City',
                      :state      => 'NY',
                      :zipcode    => '90001')
      site.address.should == '111 Sesame Street Suite 181 Gotham City NY 90001'
    end
  end

end
