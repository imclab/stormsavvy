require 'spec_helper'

describe "inspection_events/new" do
  before(:each) do
    assign(:inspection_event, stub_model(InspectionEvent,
      :site_id => 1,
      :type => "",
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new inspection_event form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => inspection_events_path, :method => "post" do
      assert_select "input#inspection_event_site_id", :name => "inspection_event[site_id]"
      assert_select "input#inspection_event_type", :name => "inspection_event[type]"
      assert_select "textarea#inspection_event_description", :name => "inspection_event[description]"
    end
  end
end
