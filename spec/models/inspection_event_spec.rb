require 'spec_helper'

describe InspectionEvent do

  before :each do
  	@site= FactoryGirl.create(:site)
  	@ie = FactoryGirl.create(:inspection_event)
  end

  it "has correct project attributes" do
  	@ie.site_id.should == 1
  	@ie.inspection_type.should == "weekly"
  	@ie.inspection_description.should == "ec jungle gym inspection"
  	@ie.inspection_date.should == "Mon, 01 Apr 2013 00:00:00 UTC +00:00"
  	@ie.submitted_by.should == "wyu"
  	@ie.inspected_by.should == "wyu"
  	@ie.completed.should == false
  end

  it 'returns correct pulldown menu values' do
    InspectionEvent::TYPES.should == [
      'CEM2023', 'CEM2024', 'CEM2030', 'CEM2034', 'CEM2035', 'CEM2040', 'CEM2041',
      'CEM2045', 'CEM2046', 'CEM2047', 'CEM2048'
    ]
  end

  it "creates a new instance given valid attributes" do
    @ie = InspectionEvent.new(@attr)
    @ie.save
    @ie.should be_valid
  end

  describe "nested scope attributes" do
    it 'has valid needs_attention attribute' do
      ie = InspectionEvent.needs_attention.build
      ie.should be_valid
    end

    it 'has valid completed attribute' do
      ie = FactoryGirl.create(:inspection_event)
      @site.inspection_events.should_not be_nil
    end
  end

  describe "inspection_event associations" do
  	before(:each) do
  	  @ie = InspectionEvent.new(@attr)
  	end

  	context :site do
  	  it "has association with a site" do
  	    @ie.should respond_to(:site)
  	  end

  	  it "has correct associated site" do
  	    @ie.should == @ie
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
      it "returns correct attachment info" do
        @attachment.attachment.url.should_not be_nil
        @attachment.attachment.url.should == '/attachments/original/missing.png'
        puts @attachment.attachment.path
        puts @attachment.attachment.url
        # @attachment.attachment.path.should_not be_nil
        # @attachment.attachment.path.should == 'user/:attachment/:style/:id.:extension'
        @attachment.attachment.bucket_name.should == 'stormsavvy'
      end
    end
  end
end
