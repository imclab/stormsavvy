require 'spec_helper'

describe Site do
  before :each do
    @site = Factory.create(:site)
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

  it "should geocode oakland" do
    s = Site.create!(:city => "Oakland")
    s.lat.round.should == 37
    s.long.round.should == -122
  end

  it "should have a project attribute" do
    @site.should respond_to(:project)
  end

end
