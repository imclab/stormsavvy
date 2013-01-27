require 'spec_helper'

describe "WeatherEvents" do
  describe "GET /weather_events" do
    it "visits weather_events path" do
      visit weather_events_path
      current_path.should == weather_events_path
    end
  end
end
