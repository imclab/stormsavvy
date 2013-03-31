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
    render
  end

  it "renders a list of inspection_events" do
    assert_select "tr>td", :text => 1.to_s, :count => 4
    assert_select "tr>td", :text => "weekly", :count => 4
    # assert_select "tr>td", :text => "ec jungle gym inspection", :count => 2
  end

  it "renders form partial correctly" do
    rendered.should =~ /Site ID/
    rendered.should =~ /Inspection Type/
    rendered.should =~ /Inspection Date/
    rendered.should =~ /Submitted By/
    rendered.should =~ /Inspected By/
    rendered.should =~ /Attachment URL/
  end

  it "renders only uploaded attachments" do
    rendered.should =~ /No attachment uploaded./
  end
end
