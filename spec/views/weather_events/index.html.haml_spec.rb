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

  xit "renders a list of weather_events" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
