require "spec_helper"

describe SitesController do
  describe "routing" do

    xit "routes to #index" do
      get :index#, :project_id => 1
      response.code.should eq("200")
      #get("projects/1/sites").should route_to("sites#index")
    end

    xit "routes to #new" do
      get("/sites/new").should route_to("sites#new")
    end

    xit "routes to #show" do
      get("/sites/1").should route_to("sites#show", :id => "1")
    end

    xit "routes to #edit" do
      get("/sites/1/edit").should route_to("sites#edit", :id => "1")
    end

    xit "routes to #create" do
      post("/sites").should route_to("sites#create")
    end

    xit "routes to #update" do
      put("/sites/1").should route_to("sites#update", :id => "1")
    end

    xit "routes to #destroy" do
      delete("/sites/1").should route_to("sites#destroy", :id => "1")
    end

  end
end
