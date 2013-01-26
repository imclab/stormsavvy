require 'spec_helper'

describe "WeatherEvents" do
  describe "GET /weather_events" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit weather_events_path
      response.should_not be_nil
      # response.status.should be(200)
    end
  end
end
