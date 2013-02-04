require 'spec_helper'

describe "inspection_events/index" do
  before(:each) do
    assign(:inspection_events, [
      stub_model(InspectionEvent,
        :site_id => 1,
        :inspection_type => "weekly",
        :inspection_description => "ec jungle gym inspection",
        :inspection_date => "2013-01-26 23:13:55",
        :submitted_by => "wyu",
        :inspected_by => "wyu"
      ),
      stub_model(InspectionEvent,
        :site_id => 1,
        :inspection_type => "weekly",
        :inspection_description => "ec jungle gym inspection",
        :inspection_date => "2013-01-26 23:13:55",
        :submitted_by => "wyu",
        :inspected_by => "wyu"
      )
    ])
  end

  it "renders a list of inspection_events" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "weekly", :count => 2
    assert_select "tr>td", :text => "ec jungle gym inspection", :count => 2
  end
end
