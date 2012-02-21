require 'spec_helper'

describe "weather_events/show" do
  before(:each) do
    @weather_event = assign(:weather_event, stub_model(WeatherEvent,
      :site_id => 1,
      :duration => 1.5,
      :rainfall => 1.5,
      :inspected => false,
      :qualifying => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
  end
end
