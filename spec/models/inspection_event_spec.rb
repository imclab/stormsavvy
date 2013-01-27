require 'spec_helper'

describe InspectionEvent do

  before :each do
  	@inspection_event = FactoryGirl.create(:inspection_event)
  	@attr = {
	  :site_id => 1,
	  :inspection_type => "weekly",
	  :inspection_description => "ec jungle gym inspection",
	  :inspection_date => "2013-01-26 23:13:55",
	  :submitted_by => "wyu",
	  :inspected_by => "wyu"
  	}
  end
  it "has correct project attributes" do
	@inspection_event.site_id.should == 1
	@inspection_event.inspection_type.should == "weekly"
	@inspection_event.inspection_description.should == "ec jungle gym inspection"
	@inspection_event.inspection_date.should == "2013-01-26 23:13:55"
	@inspection_event.submitted_by.should == "wyu"
	@inspection_event.inspected_by.should == "wyu"
  end
  it "should create a new instance given valid attributes" do
    @inspection_event = InspectionEvent.new(@attr)
    @inspection_event.save
    @inspection_event.should be_valid
  end

  describe "project associations" do

	before(:each) do
	  @inspection_event = InspectionEvent.new(@attr)
	end

	context :site do
	  it "should be associated with a site" do
	    @project.should respond_to(:site)
	  end
	  it "should have the correct associated user" do
	    @project.should == @project
	  end
	end
  end
end
