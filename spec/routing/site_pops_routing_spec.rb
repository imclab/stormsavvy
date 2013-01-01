require "spec_helper"

describe SitePopsController do
  describe "routing" do

    it "routes to #index" do
      get("/site_pops").should route_to("site_pops#index")
    end

    it "routes to #new" do
      get("/site_pops/new").should route_to("site_pops#new")
    end

    it "routes to #show" do
      get("/site_pops/1").should route_to("site_pops#show", :id => "1")
    end

    it "routes to #edit" do
      get("/site_pops/1/edit").should route_to("site_pops#edit", :id => "1")
    end

    it "routes to #create" do
      post("/site_pops").should route_to("site_pops#create")
    end

    it "routes to #update" do
      put("/site_pops/1").should route_to("site_pops#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/site_pops/1").should route_to("site_pops#destroy", :id => "1")
    end

  end
end
