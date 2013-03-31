require 'spec_helper'

describe "inspection_events/edit" do
  before(:each) do
    @inspection_event = assign(:inspection_event, stub_model(InspectionEvent,
      :site_id => 1,
      :inspection_type => "weekly",
      :inspection_description => "ec jungle gym inspection",
      :inspection_date => "2013-01-26 23:13:55",
      :submitted_by => "wyu",
      :inspected_by => "wyu",
      :completed => false
    ))
  end

  it "renders the edit inspection_event form" do
    render
    assert_select "form", :action => inspection_events_path(@inspection_event), :method => "post" do
      assert_select "input#inspection_event_site_id", :name => "inspection_event[site_id]"
      assert_select "input#inspection_event_inspection_type", :name => "inspection_event[inspection_type]"
      assert_select "textarea#inspection_event_inspection_description", :name => "inspection_event[inspection_description]"
      assert_select "input#inspection_event_submitted_by", :name => "inspection_event[submitted_by]"
      assert_select "input#inspection_event_inspected_by", :name => "inspection_event[inspected_by]"
      assert_select "input#inspection_event_completed", :name => "inspection_event[completed]"
      assert_select "input#inspection_event_attachment", :name => "inspection_event[attachment]", :class => "button"

      # need proper field method for datetime
      # assert_select "input#inspection_event_inspection_date", :name => "inspection_event[inspection_date]"
    end
  end

  it "renders form partial correctly" do
    render
    rendered.should =~ /Edit Inspection Event/
    rendered.should =~ /Completed/
    rendered.should =~ /Site/
    rendered.should =~ /Inspection type/
    rendered.should =~ /Inspection date/
    rendered.should =~ /Submitted by/
    rendered.should =~ /Inspected by/
    rendered.should =~ /Inspection description/
    rendered.should =~ /Save/
    rendered.should =~ /Back/
    rendered.should =~ /Save/
    rendered.should =~ /Back/
  end

  describe 'file attachment partial' do
    before(:each) do
      assign(:inspection_events, [
        stub_model(InspectionEvent),
        stub_model(InspectionEvent)
      ])
      @inspection_event = FactoryGirl.create(:inspection_event, :id => 1)
      render
    end

    it "renders partial correctly" do
      rendered.should_not be_nil
      rendered.should =~ /Instructions: Attach File & Complete Description Below/
      rendered.should =~ /Cancel/
    end
  end
end
