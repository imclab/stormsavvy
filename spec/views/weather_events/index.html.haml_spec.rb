require 'spec_helper'

describe "weather_events/index" do
  before(:each) do
    assign(:weather_events, [
      stub_model(WeatherEvent,
        :site_id => 1,
        :duration => 1.5,
        :rainfall => 1.5,
        :inspected => false,
        :qualifying => false
      ),
      stub_model(WeatherEvent,
        :site_id => 1,
        :duration => 1.5,
        :rainfall => 1.5,
        :inspected => false,
        :qualifying => false
      )
    ])
  end

  it "renders a list of weather_events" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 4
    assert_select "tr>td", :text => 1.5.to_s, :count => 4
    assert_select "tr>td", :text => false.to_s, :count => 4
    assert_select "tr>td", :text => false.to_s, :count => 4
  end
end
