require 'spec_helper'

describe "inspection_events/show" do
  before(:each) do
    @site = FactoryGirl.create(
      :site,
      :id => 1,
      :name => 'ec jungle gym'
    )
    @site_ie = FactoryGirl.create(
      :inspection_event,
      :site_id => 1
    )
    @ie = assign(
      :inspection_event, stub_model(
        InspectionEvent,
        :site_id => 1,
        :inspection_type => "weekly",
        :inspection_description => "ec jungle gym inspection",
        :inspection_date => "2013-01-26 23:13:55",
        :submitted_by => "wyu",
        :inspected_by => "wyu"
      )
    )
    render
  end

  it "renders attributes in <p>" do
    rendered.should match(/1/)
    rendered.should match(/weekly/)
    rendered.should match(/ec jungle gym inspection/)
  end

  it "renders correct columns" do
    rendered.should match(/Site ID:/)
    rendered.should match(/Inspection Type:/)
    rendered.should match(/Description:/)
    rendered.should match(/Date:/)
    rendered.should match(/Submitted By:/)
    rendered.should match(/Inspected By:/)
  end

  it "has edit, back and delete links" do
    rendered.should match(/Edit/)
    rendered.should match(/Back/)
    rendered.should match(/Delete/)

    rendered.should have_link('Edit')
    rendered.should have_link('Back')
    rendered.should have_button('Delete This Inspection Event')
  end
end
