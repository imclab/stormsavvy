require 'spec_helper'

describe "inspection_events/show" do
  before(:each) do
    @inspection_event = assign(:inspection_event, stub_model(InspectionEvent,
      :site_id => 1,
      :type => "Type",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Type/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
  end

  it "renders edit / back / delete links" do
    render
    rendered.should match(/Edit/)
    rendered.should match(/Back/)
    rendered.should match(/Delete/)
  end
end
