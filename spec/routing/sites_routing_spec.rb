require "spec_helper"

describe SitesController do

  describe "routing" do

    @@attrs = {
      :name => 'Project',
      :description => 'My description',
      :startdate => 5.days.ago,
      :finishdate => 1.day.ago
    }

    before(:each) do
      @user = Factory(:user)
      @project = @user.projects.create!(@@attrs)
    end

    it "routes to #index" do
      { :get => project_sites_path(@project.to_param) }
      .should route_to(:controller => "sites", :action => "index", :project_id => @project.to_param)
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
