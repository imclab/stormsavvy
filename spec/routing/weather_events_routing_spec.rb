require "spec_helper"

describe WeatherEventsController do
  describe "routing" do

    it "routes to #index" do
      get("/weather_events").should route_to("weather_events#index")
    end

    it "routes to #new" do
      get("/weather_events/new").should route_to("weather_events#new")
    end

    it "routes to #show" do
      get("/weather_events/1").should route_to("weather_events#show", :id => "1")
    end

    it "routes to #edit" do
      get("/weather_events/1/edit").should route_to("weather_events#edit", :id => "1")
    end

    it "routes to #create" do
      post("/weather_events").should route_to("weather_events#create")
    end

    it "routes to #update" do
      put("/weather_events/1").should route_to("weather_events#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/weather_events/1").should route_to("weather_events#destroy", :id => "1")
    end

  end
end
