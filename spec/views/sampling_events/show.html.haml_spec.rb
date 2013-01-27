require 'spec_helper'

describe "sampling_events/show" do
  before(:each) do
    @sampling_event = assign(:sampling_event, stub_model(SamplingEvent,
      :site_id => 1,
      :sampling_type => "Sampling Type",
      :sampling_description => "MyText",
      :submitted_by => "Submitted By",
      :sampled_by => "Sampled By",
      :sample_id_1 => 2,
      :sample_location_1 => "Sample Location 1",
      :analysis_type_1 => "Analysis Type 1",
      :analysis_result_1 => "Analysis Result 1",
      :analysis_average_1 => "Analysis Average 1",
      :sample_id_2 => 3,
      :sample_location_2 => "Sample Location 2",
      :analysis_type_2 => "Analysis Type 2",
      :analysis_result_2 => "Analysis Result 2",
      :analysis_average_2 => "Analysis Average 2",
      :sample_id_3 => 4,
      :sample_location_3 => "Sample Location 3",
      :analysis_type_3 => "Analysis Type 3",
      :analysis_result_3 => "Analysis Result 3",
      :analysis_average_3 => "Analysis Average 3",
      :sample_id_4 => 5,
      :sample_location_4 => "Sample Location 4",
      :analysis_type_4 => "Analysis Type 4",
      :analysis_result_4 => "Analysis Result 4",
      :analysis_average_4 => "Analysis Average 4",
      :sample_id_5 => 6,
      :sample_location_5 => "Sample Location 5",
      :analysis_type_5 => "Analysis Type 5",
      :analysis_result_5 => "Analysis Result 5",
      :analysis_average_5 => "Analysis Average 5"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Sampling Type/)
    rendered.should match(/MyText/)
    rendered.should match(/Submitted By/)
    rendered.should match(/Sampled By/)
    rendered.should match(/2/)
    rendered.should match(/Sample Location 1/)
    rendered.should match(/Analysis Type 1/)
    rendered.should match(/Analysis Result 1/)
    rendered.should match(/Analysis Average 1/)
    rendered.should match(/3/)
    rendered.should match(/Sample Location 2/)
    rendered.should match(/Analysis Type 2/)
    rendered.should match(/Analysis Result 2/)
    rendered.should match(/Analysis Average 2/)
    rendered.should match(/4/)
    rendered.should match(/Sample Location 3/)
    rendered.should match(/Analysis Type 3/)
    rendered.should match(/Analysis Result 3/)
    rendered.should match(/Analysis Average 3/)
    rendered.should match(/5/)
    rendered.should match(/Sample Location 4/)
    rendered.should match(/Analysis Type 4/)
    rendered.should match(/Analysis Result 4/)
    rendered.should match(/Analysis Average 4/)
    rendered.should match(/6/)
    rendered.should match(/Sample Location 5/)
    rendered.should match(/Analysis Type 5/)
    rendered.should match(/Analysis Result 5/)
    rendered.should match(/Analysis Average 5/)
  end
end
