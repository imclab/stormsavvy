require 'spec_helper'

describe "weather_events/edit" do
  before(:each) do
    @weather_event = assign(:weather_event, stub_model(WeatherEvent,
      :site_id => 1,
      :duration => 1.5,
      :rainfall => 1.5,
      :inspected => false,
      :qualifying => false
    ))
  end

  it "renders the edit weather_event form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => weather_events_path(@weather_event), :method => "post" do
      assert_select "input#weather_event_site_id", :name => "weather_event[site_id]"
      assert_select "input#weather_event_duration", :name => "weather_event[duration]"
      assert_select "input#weather_event_rainfall", :name => "weather_event[rainfall]"
      assert_select "input#weather_event_inspected", :name => "weather_event[inspected]"
      assert_select "input#weather_event_qualifying", :name => "weather_event[qualifying]"
    end
  end
end
