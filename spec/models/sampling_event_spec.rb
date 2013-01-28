require 'spec_helper'

describe SamplingEvent do
  before :each do
  	@sampling_event = FactoryGirl.create(:inspection_event)
  	@attr = {
    :site_id => 1,
    :sampling_type => "pH",
    :sampling_description => "ec jungle gym samplng",
    :sampling_date => "2013-01-27 15:34:07",
    :submitted_by => "wyu",
    :sampled_by => "wyu",
    :sample_id_1 => 1,
    :sample_location_1 => "jungle gym",
    :sample_time_1 => "2013-01-27 15:34:07",
    :analysis_type_1 => "pH",
    :analysis_result_1 => "7.00",
    :analysis_average_1 => "7.01",
    :sample_id_2 => 1,
    :sample_location_2 => "playground slide",
    :sample_time_2 => "2013-01-27 15:34:07",
    :analysis_type_2 => "pH",
    :analysis_result_2 => "7.10",
    :analysis_average_2 => "7.01",
    :sample_id_3 => 1,
    :sample_location_3 => "playground seesaw",
    :sample_time_3 => "2013-01-27 15:34:07",
    :analysis_type_3 => "pH",
    :analysis_result_3 => "6.90",
    :analysis_average_3 => "7.01",
    :sample_id_4 => 1,
    :sample_location_4 => "merry go round",
    :sample_time_4 => "2013-01-27 15:34:07",
    :analysis_type_4 => "pH",
    :analysis_result_4 => "6.95",
    :analysis_average_4 => "7.01",
    :sample_id_5 => 1,
    :sample_location_5 => "playground swings",
    :sample_time_5 => "2013-01-27 15:34:07",
    :analysis_type_5 => "pH",
    :analysis_result_5 => "7.20",
    :analysis_average_5 => "7.01"
  	}
  end

  it "has correct attributes" do
    @sampling_event.site_id.should == 1
    @sampling_event.sampling_type.should == "pH"
    @sampling_event.sampling_description.should == "ec jungle gym samplng"
    @sampling_event.sampling_date.should == "2013-01-27 15:34:07"
    @sampling_event.submitted_by.should == "wyu"
    @sampling_event.sampled_by.should => "wyu"
    @sampling_event.sample_id_1.should => 1
    @sampling_event.sample_location_1.should => "jungle gym"
    @sampling_event.sample_time_1.should => "2013-01-27 15:34:07"
    @sampling_event.analysis_type_1.should => "pH"
    @sampling_event.analysis_result_1.should => "7.00"
    @sampling_event.analysis_average_1.should => "7.01"
    @sampling_event.sample_id_2.should => 1
    @sampling_event.sample_location_2.should => "playground slide"
    @sampling_event.sample_time_2.should => "2013-01-27 15:34:07"
    @sampling_event.analysis_type_2.should => "pH"
    @sampling_event.analysis_result_2.should => "7.10"
    @sampling_event.analysis_average_2.should => "7.01"
    @sampling_event.sample_id_3.should => 1
    @sampling_event.sample_location_3.should => "playground seesaw"
    @sampling_event.sample_time_3.should => "2013-01-27 15:34:07"
    @sampling_event.analysis_type_3.should => "pH"
    @sampling_event.analysis_result_3.should => "6.90"
    @sampling_event.analysis_average_3.should=> "7.01"
    @sampling_event.sample_id_4.should => 1
    @sampling_event.sample_location_4.should => "merry go round"
    @sampling_event.sample_time_4.should => "2013-01-27 15:34:07"
    @sampling_event.analysis_type_4.should => "pH"
    @sampling_event.analysis_result_4.should => "6.95"
    @sampling_event.analysis_average_4.should => "7.01"
    @sampling_event.sample_id_5.should => 1
    @sampling_event.sample_location_5.should => "playground swings"
    @sampling_event.sample_time_5.should => "2013-01-27 15:34:07"
    @sampling_event.analysis_type_5.should => "pH"
    @sampling_event.analysis_result_5.should => "7.20"
    @sampling_event.analysis_average_5.should => "7.01"
  end
  it "creates new instance given valid attributes" do
    sampling_event = SamplingEvent.new(@attr)
    sampling_event.save
    sampling_event.should be_valid
  end
end
