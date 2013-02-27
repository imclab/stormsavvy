require 'spec_helper'

describe "sampling_events/edit" do
  before(:each) do
    @sampling_event = assign(:sampling_event, stub_model(SamplingEvent,
      :site_id => 1,
      :sampling_type => "MyString",
      :sampling_description => "MyText",
      :submitted_by => "MyString",
      :sampled_by => "MyString",
      :sample_id_1 => 1,
      :sample_location_1 => "MyString",
      :analysis_type_1 => "MyString",
      :analysis_result_1 => "MyString",
      :analysis_average_1 => "MyString",
      :sample_id_2 => 1,
      :sample_location_2 => "MyString",
      :analysis_type_2 => "MyString",
      :analysis_result_2 => "MyString",
      :analysis_average_2 => "MyString",
      :sample_id_3 => 1,
      :sample_location_3 => "MyString",
      :analysis_type_3 => "MyString",
      :analysis_result_3 => "MyString",
      :analysis_average_3 => "MyString",
      :sample_id_4 => 1,
      :sample_location_4 => "MyString",
      :analysis_type_4 => "MyString",
      :analysis_result_4 => "MyString",
      :analysis_average_4 => "MyString",
      :sample_id_5 => 1,
      :sample_location_5 => "MyString",
      :analysis_type_5 => "MyString",
      :analysis_result_5 => "MyString",
      :analysis_average_5 => "MyString"
    ))
  end

  it "renders the edit sampling_event form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => sampling_events_path(@sampling_event), :method => "post" do
      assert_select "input#sampling_event_site_id", :name => "sampling_event[site_id]"
      assert_select "input#sampling_event_sampling_type", :name => "sampling_event[sampling_type]"
      # assert_select "textarea#sampling_event_sampling_description", :name => "sampling_event[sampling_description]"
      assert_select "input#sampling_event_submitted_by", :name => "sampling_event[submitted_by]"
      assert_select "input#sampling_event_sampled_by", :name => "sampling_event[sampled_by]"
      assert_select "input#sampling_event_sample_id_1", :name => "sampling_event[sample_id_1]"
      assert_select "input#sampling_event_sample_location_1", :name => "sampling_event[sample_location_1]"
      assert_select "input#sampling_event_analysis_type_1", :name => "sampling_event[analysis_type_1]"
      assert_select "input#sampling_event_analysis_result_1", :name => "sampling_event[analysis_result_1]"
      assert_select "input#sampling_event_analysis_average_1", :name => "sampling_event[analysis_average_1]"
      assert_select "input#sampling_event_sample_id_2", :name => "sampling_event[sample_id_2]"
      assert_select "input#sampling_event_sample_location_2", :name => "sampling_event[sample_location_2]"
      assert_select "input#sampling_event_analysis_type_2", :name => "sampling_event[analysis_type_2]"
      assert_select "input#sampling_event_analysis_result_2", :name => "sampling_event[analysis_result_2]"
      assert_select "input#sampling_event_analysis_average_2", :name => "sampling_event[analysis_average_2]"
      assert_select "input#sampling_event_sample_id_3", :name => "sampling_event[sample_id_3]"
      assert_select "input#sampling_event_sample_location_3", :name => "sampling_event[sample_location_3]"
      assert_select "input#sampling_event_analysis_type_3", :name => "sampling_event[analysis_type_3]"
      assert_select "input#sampling_event_analysis_result_3", :name => "sampling_event[analysis_result_3]"
      assert_select "input#sampling_event_analysis_average_3", :name => "sampling_event[analysis_average_3]"
      assert_select "input#sampling_event_sample_id_4", :name => "sampling_event[sample_id_4]"
      assert_select "input#sampling_event_sample_location_4", :name => "sampling_event[sample_location_4]"
      assert_select "input#sampling_event_analysis_type_4", :name => "sampling_event[analysis_type_4]"
      assert_select "input#sampling_event_analysis_result_4", :name => "sampling_event[analysis_result_4]"
      assert_select "input#sampling_event_analysis_average_4", :name => "sampling_event[analysis_average_4]"
      assert_select "input#sampling_event_sample_id_5", :name => "sampling_event[sample_id_5]"
      assert_select "input#sampling_event_sample_location_5", :name => "sampling_event[sample_location_5]"
      assert_select "input#sampling_event_analysis_type_5", :name => "sampling_event[analysis_type_5]"
      assert_select "input#sampling_event_analysis_result_5", :name => "sampling_event[analysis_result_5]"
      assert_select "input#sampling_event_analysis_average_5", :name => "sampling_event[analysis_average_5]"
    end
  end
end
