require 'spec_helper'

describe InspectionEvent do

  let(:site) { FactoryGirl.create(
    :site,
    :name => 'ec jungle gym'
    )
  }
  let(:ie) { FactoryGirl.create(
    :inspection_event,
    :site => site,
    :site_id => site.object_id
    )
  }

  describe 'valid attributes' do
    it "has correct project attributes" do
      ie.site_id.should == 1
      ie.inspection_type.should == "weekly"
      ie.inspection_description.should == "ec jungle gym inspection"
      ie.inspection_date.should == "Mon, 01 Apr 2013 00:00:00 UTC +00:00"
      ie.submitted_by.should == "wyu"
      ie.inspected_by.should == "wyu"
      ie.completed.should == false
    end

    it 'returns correct pulldown menu values' do
      InspectionEvent::TYPES.should == [
        'CEM2023', 'CEM2024', 'CEM2030', 'CEM2034', 'CEM2035', 'CEM2040', 'CEM2041',
        'CEM2045', 'CEM2046', 'CEM2047', 'CEM2048'
      ]
    end

    it "creates a new instance given valid attributes" do
      site = Site.new
      ie = InspectionEvent.new(
        :site => site,
        :site_id => site.object_id
      )
      ie.save
      ie.should be_valid
    end

    it 'requires site_id for new inspection_event' do
      no_name = InspectionEvent.new
      no_name.should_not be_valid
    end

    it 'has site name' do
      ie.site.name.should == 'ec jungle gym'
    end
  end

  describe "nested scope attributes" do
    it 'has valid needs_attention attribute' do
      ie = InspectionEvent.needs_attention.build(
        :site => site,
        :site_id => site.object_id
      )
      ie.should be_valid
    end

    it 'has valid completed attribute' do
      # ie = FactoryGirl.create(:inspection_event)
      site.inspection_events.should_not be_nil
    end
  end

  describe "associations" do
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
        @attachment.attachment.bucket_name.should == 'stormsavvy'
      end
    end
  end
end
