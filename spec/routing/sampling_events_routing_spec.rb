require "spec_helper"

describe SamplingEventsController do
  describe "routing" do

    it "routes to #index" do
      get("/sampling_events").should route_to("sampling_events#index")
    end

    it "routes to #new" do
      get("/sampling_events/new").should route_to("sampling_events#new")
    end

    it "routes to #show" do
      get("/sampling_events/1").should route_to("sampling_events#show", :id => "1")
    end

    it "routes to #edit" do
      get("/sampling_events/1/edit").should route_to("sampling_events#edit", :id => "1")
    end

    it "routes to #create" do
      post("/sampling_events").should route_to("sampling_events#create")
    end

    it "routes to #update" do
      put("/sampling_events/1").should route_to("sampling_events#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/sampling_events/1").should route_to("sampling_events#destroy", :id => "1")
    end

  end
end
