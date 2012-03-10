require 'spec_helper'

describe Site do

  describe "validations" do

    before(:each) do
      @site   = Factory.create(:site)
    end

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
      @project = Factory(:project)
      @site = Factory.create(:site)
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
      @site   = Factory.create(:site)
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
      s = Site.create!(:name    => "Oakland Adams Point",
                       :city    => "Oakland",
                       :zipcode => 94610)
      s.lat.round.should == 38
      s.long.round.should == -122
    end
  end
  
end
