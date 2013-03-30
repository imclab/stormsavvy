require 'spec_helper'

describe "inspection_events/show" do
  before(:each) do
    @inspection_event = assign(:inspection_event, stub_model(InspectionEvent,
      :site_id => 1,
      :inspection_type => "weekly",
      :inspection_description => "ec jungle gym inspection",
      :inspection_date => "2013-01-26 23:13:55",
      :submitted_by => "wyu",
      :inspected_by => "wyu"
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should match(/1/)
    rendered.should match(/weekly/)
    rendered.should match(/ec jungle gym inspection/)
  end

  it "renders correct columns" do
    render
    rendered.should match(/Site ID:/)
    rendered.should match(/Inspection Type:/)
    rendered.should match(/Description:/)
    rendered.should match(/Date:/)
    rendered.should match(/Submitted By:/)
    rendered.should match(/Inspected By:/)
  end

  it "renders edit / back / delete links" do
    render
    rendered.should match(/Edit/)
    rendered.should match(/Back/)
    rendered.should match(/Delete/)
  end
end
