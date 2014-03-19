require 'spec_helper'

describe SamplingEvent do

  let!(:site) { FactoryGirl.create(:site) }
  let!(:se) { FactoryGirl.create(
      :sampling_event,
      site: site
    )
  }
  let!(:sampling_event) { FactoryGirl.create(:sampling_event) }

  before :each do
  	@attr = {
      :site => site,
      :sampling_type => "pH",
      :sampling_description => "ec jungle gym sampling",
      :sampling_date => "2013-01-27 15:34:07",
      :submitted_by => "wyu",
      :sampled_by => "wyu",
      :sample_id_1 => 1,
      :sample_location_1 => "jungle gym",
      :sample_time_1 => "2000-01-01 15:34:07 UTC",
      :analysis_type_1 => "pH",
      :analysis_result_1 => "7.00",
      :analysis_average_1 => "7.01",
      :sample_id_2 => 1,
      :sample_location_2 => "playground slide",
      :sample_time_2 => "2000-01-01 15:34:07 UTC",
      :analysis_type_2 => "pH",
      :analysis_result_2 => "7.10",
      :analysis_average_2 => "7.01",
      :sample_id_3 => 1,
      :sample_location_3 => "playground seesaw",
      :sample_time_3 => "2000-01-01 15:34:07 UTC",
      :analysis_type_3 => "pH",
      :analysis_result_3 => "6.90",
      :analysis_average_3 => "7.01",
      :sample_id_4 => 1,
      :sample_location_4 => "merry go round",
      :sample_time_4 => "2000-01-01 15:34:07 UTC",
      :analysis_type_4 => "pH",
      :analysis_result_4 => "6.95",
      :analysis_average_4 => "7.01",
      :sample_id_5 => 1,
      :sample_location_5 => "playground swings",
      :sample_time_5 => "2000-01-01 15:34:07 UTC",
      :analysis_type_5 => "pH",
      :analysis_result_5 => "7.20",
      :analysis_average_5 => "7.01"
  	}
  end

  describe 'valid attributes' do
    it "has correct attributes" do
      sampling_event.site_id.should == 1
      sampling_event.sampling_type.should == "pH"
      sampling_event.sampling_description.should == "ec jungle gym sampling"
      sampling_event.sampling_date.should == "2013-01-27 15:34:07"
      sampling_event.submitted_by.should == "wyu"
      sampling_event.sampled_by.should == "wyu"
      sampling_event.sample_id_1.should == 1
      sampling_event.sample_location_1.should == "jungle gym"
      sampling_event.sample_time_1.should == "2000-01-01 15:34:07 UTC"
      sampling_event.analysis_type_1.should == "pH"
      sampling_event.analysis_result_1.should == "7.00"
      sampling_event.analysis_average_1.should == "7.01"
      sampling_event.sample_id_2.should == 1
      sampling_event.sample_location_2.should == "playground slide"
      sampling_event.sample_time_2.should == "2000-01-01 15:34:07 UTC"
      sampling_event.analysis_type_2.should == "pH"
      sampling_event.analysis_result_2.should == "7.10"
      sampling_event.analysis_average_2.should == "7.01"
      sampling_event.sample_id_3.should == 1
      sampling_event.sample_location_3.should == "playground seesaw"
      sampling_event.sample_time_3.should == "2000-01-01 15:34:07 UTC"
      sampling_event.analysis_type_3.should == "pH"
      sampling_event.analysis_result_3.should == "6.90"
      sampling_event.analysis_average_3.should== "7.01"
      sampling_event.sample_id_4.should == 1
      sampling_event.sample_location_4.should == "merry go round"
      sampling_event.sample_time_4.should == "2000-01-01 15:34:07 UTC"
      sampling_event.analysis_type_4.should == "pH"
      sampling_event.analysis_result_4.should == "6.95"
      sampling_event.analysis_average_4.should == "7.01"
      sampling_event.sample_id_5.should == 1
      sampling_event.sample_location_5.should == "playground swings"
      sampling_event.sample_time_5.should == "2000-01-01 15:34:07 UTC"
      sampling_event.analysis_type_5.should == "pH"
      sampling_event.analysis_result_5.should == "7.20"
      sampling_event.analysis_average_5.should == "7.01"
    end

    it 'returns correct pulldown menu values' do
      SamplingEvent::TYPES.should == [ 
        'Daily Monitoring', 'Creek Diversion Monitoring', 'Rain Event Sampling' 'Notice of Discharge'
      ]
    end

    it "creates new instance given valid attributes" do
      sampling_event = SamplingEvent.new(@attr)
      sampling_event.save
      sampling_event.should be_valid
    end

    it 'requires site_id for new sampling_event' do
      no_name = SamplingEvent.new
      no_name.should_not be_valid
    end
  end

  describe "associations" do
    before(:each) do
      @sampling_event = SamplingEvent.new(@attr)
    end

    context :site do
      it "has an association with a site" do
        @sampling_event.should respond_to(:site)
      end

      it "has the correct associated user" do
        @sampling_event.should == @sampling_event
      end
    end
  end

  describe 'file attachments' do
    before do
      SamplingEvent.any_instance.stub(:save_attached_files).and_return(true) 
      SamplingEvent.any_instance.stub(:destroy_attached_files).and_return(true) 
      @attachment = FactoryGirl.create :sampling_event
    end

    describe "#attachment" do
      it "returns correct url" do
        @attachment.attachment.url.should_not be_nil
      end
    end
  end
end
