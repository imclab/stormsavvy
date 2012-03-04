require 'spec_helper'

describe "WeatherEvents" do
  describe "GET /weather_events" do
    it "returns weather events successfully" do
      get weather_events_path
      response.status.should be(200)
    end
  end
end
