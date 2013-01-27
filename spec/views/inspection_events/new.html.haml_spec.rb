require 'spec_helper'

describe "inspection_events/new" do
  before(:each) do
    assign(:inspection_event, stub_model(InspectionEvent,
    :site_id => 1,
    :inspection_type => "weekly",
    :inspection_description => "ec jungle gym inspection",
    :inspection_date => "2013-01-26 23:13:55",
    :submitted_by => "wyu",
    :inspected_by => "wyu"
    ).as_new_record)
  end

  it "renders new inspection_event form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => inspection_events_path, :method => "post" do
      assert_select "input#inspection_event_site_id", :name => "inspection_event[site_id]"
      assert_select "input#inspection_event_inspection_type", :name => "inspection_event[inspection_type]"
      assert_select "textarea#inspection_event_inspection_description", :name => "inspection_event[inspection_description]"
      assert_select "input#inspection_event_inspection_date", :name => "inspection_event[inspection_date]"
      assert_select "input#inspection_event_submitted_by", :name => "inspection_event[submitted_by]"
      assert_select "input#inspection_event_inspected_by", :name => "inspection_event[inspected_by]"
    end
  end
end