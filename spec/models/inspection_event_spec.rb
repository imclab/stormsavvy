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

  it "creates a new instance given valid attributes" do
    @inspection_event = InspectionEvent.new(@attr)
    @inspection_event.save
    @inspection_event.should be_valid
  end

  describe "inspection_event associations" do
  	before(:each) do
  	  @inspection_event = InspectionEvent.new(@attr)
  	end

  	context :site do
  	  it "has association with a site" do
  	    @inspection_event.should respond_to(:site)
  	  end
  	  it "has correct associated site" do
  	    @inspection_event.should == @inspection_event
  	  end
  	end  
  end

  describe 'file attachments' do
    before do
      InspectionEvent.any_instance.stub(:save_attached_files).and_return(true) 
      InspectionEvent.any_instance.stub(:destroy_attached_files).and_return(true) 
      @attachment = FactoryGirl.create :inspection_event
    end
    describe "#attachment" do
      it "returns correct url" do
        @attachment.attachment.url.should_not be_nil
      end
    end
  end
end
