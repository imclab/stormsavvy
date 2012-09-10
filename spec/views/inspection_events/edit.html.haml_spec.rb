require 'spec_helper'

describe "inspection_events/edit" do
  before(:each) do
    @inspection_event = assign(:inspection_event, stub_model(InspectionEvent,
      :site_id => 1,
      :type => "",
      :description => "MyText"
    ))
  end

  it "renders the edit inspection_event form" do
    render
    assert_select "form", :action => inspection_events_path(@inspection_event), :method => "post" do
      assert_select "input#inspection_event_site_id", :name => "inspection_event[site_id]"
      assert_select "input#inspection_event_type", :name => "inspection_event[type]"
      assert_select "textarea#inspection_event_description", :name => "inspection_event[description]"
    end
  end
end
