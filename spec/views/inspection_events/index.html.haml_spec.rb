require 'spec_helper'

describe "inspection_events/index" do
  before(:each) do
    assign(:inspection_events, [
      stub_model(InspectionEvent,
        :site_id => 1,
        :type => "Type",
        :description => "MyText"
      ),
      stub_model(InspectionEvent,
        :site_id => 1,
        :type => "Type",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of inspection_events" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
