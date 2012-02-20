require "spec_helper"

describe InspectionEventsController do
  describe "routing" do

    it "routes to #index" do
      get("/inspection_events").should route_to("inspection_events#index")
    end

    it "routes to #new" do
      get("/inspection_events/new").should route_to("inspection_events#new")
    end

    it "routes to #show" do
      get("/inspection_events/1").should route_to("inspection_events#show", :id => "1")
    end

    it "routes to #edit" do
      get("/inspection_events/1/edit").should route_to("inspection_events#edit", :id => "1")
    end

    it "routes to #create" do
      post("/inspection_events").should route_to("inspection_events#create")
    end

    it "routes to #update" do
      put("/inspection_events/1").should route_to("inspection_events#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/inspection_events/1").should route_to("inspection_events#destroy", :id => "1")
    end

  end
end
