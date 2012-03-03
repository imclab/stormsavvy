require "spec_helper"

describe LocationsController do
  describe "routing" do

    it "routes to #index" do
      get("/weather_events").should route_to("weather_events#index")
    end

    it "routes to #new" do
      get("/weather_events/new").should route_to("weather_events#new")
    end

    it "routes to #create" do
      post("/weather_events").should route_to("weather_events#create")
    end

  end
end
