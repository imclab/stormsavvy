require 'spec_helper'

describe "sampling_events/index" do
  before(:each) do
    assign(:sampling_events, [
      stub_model(SamplingEvent,
        :site_id => 1,
        :sampling_type => "Sampling Type",
        :sampling_description => "Sampling Description",
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
      ),
      stub_model(SamplingEvent,
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
      )
    ])
  end

  it "renders a list of sampling_events" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Sampling Type".to_s, :count => 2
    # assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # assert_select "tr>td", :text => "Submitted By".to_s, :count => 2
    # assert_select "tr>td", :text => "Sampled By".to_s, :count => 2
    # assert_select "tr>td", :text => 2.to_s, :count => 2
    # assert_select "tr>td", :text => "Sample Location 1".to_s, :count => 2
    # assert_select "tr>td", :text => "Analysis Type 1".to_s, :count => 2
    # assert_select "tr>td", :text => "Analysis Result 1".to_s, :count => 2
    # assert_select "tr>td", :text => "Analysis Average 1".to_s, :count => 2
    # assert_select "tr>td", :text => 3.to_s, :count => 2
    # assert_select "tr>td", :text => "Sample Location 2".to_s, :count => 2
    # assert_select "tr>td", :text => "Analysis Type 2".to_s, :count => 2
    # assert_select "tr>td", :text => "Analysis Result 2".to_s, :count => 2
    # assert_select "tr>td", :text => "Analysis Average 2".to_s, :count => 2
    # assert_select "tr>td", :text => 4.to_s, :count => 2
    # assert_select "tr>td", :text => "Sample Location 3".to_s, :count => 2
    # assert_select "tr>td", :text => "Analysis Type 3".to_s, :count => 2
    # assert_select "tr>td", :text => "Analysis Result 3".to_s, :count => 2
    # assert_select "tr>td", :text => "Analysis Average 3".to_s, :count => 2
    # assert_select "tr>td", :text => 5.to_s, :count => 2
    # assert_select "tr>td", :text => "Sample Location 4".to_s, :count => 2
    # assert_select "tr>td", :text => "Analysis Type 4".to_s, :count => 2
    # assert_select "tr>td", :text => "Analysis Result 4".to_s, :count => 2
    # assert_select "tr>td", :text => "Analysis Average 4".to_s, :count => 2
    # assert_select "tr>td", :text => 6.to_s, :count => 2
    # assert_select "tr>td", :text => "Sample Location 5".to_s, :count => 2
    # assert_select "tr>td", :text => "Analysis Type 5".to_s, :count => 2
    # assert_select "tr>td", :text => "Analysis Result 5".to_s, :count => 2
    # assert_select "tr>td", :text => "Analysis Average 5".to_s, :count => 2
  end

  it "renders form partial correctly" do
    render
    rendered.should =~ /Sampling Type/
    rendered.should =~ /Sampling Description/
    rendered.should =~ /Submitted By/
    rendered.should =~ /Sampled By/
  end
end
