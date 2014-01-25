require "spec_helper"

describe SitesController do

  describe "routing" do

    let(:user) { FactoryGirl.build(:user) }
    let(:site) { FactoryGirl.create(
      :site,
      user: user
      )
    }
    before(:each) do
    end

    it "routes to #index" do
      { :get => sites_path(site.to_param) }
      .should route_to(:controller => "sites", :action => "index", :format => site.to_param)
      # .should route_to(:controller => "sites", :action => "users_sites", :format => @site.to_param)
      # { :get => project_sites_path(@project.to_param) }
      # .should route_to(:controller => "sites", :action => "index", :project_id => @project.to_param)
    end

    it "routes to #new" do
      { :get => new_site_path(site.to_param) }
      .should route_to(:controller => "sites", :action => "new", :format => site.to_param)
      # { :get => new_project_site_path(@project.to_param) }
      # .should route_to(:controller => "sites", :action => "new", :project_id => @project.to_param)
    end

    it "routes to #show" do
      { :get => site_path(site.to_param) }
      .should route_to(:controller => "sites", :action => "show", :id => site.to_param)
      # { :get => project_site_path(@project.to_param, @site.to_param) }
      # .should route_to(:controller => "sites", :action => "show", 
      #                  :project_id => @project.to_param, :id => @site.to_param)
    end

    it "routes to #edit" do
      { :get => edit_site_path(site.to_param) }
      .should route_to(:controller => "sites", :action => "edit", :id => site.to_param)
      # { :get => edit_project_site_path(@project.to_param, @site.to_param) }
      # .should route_to(:controller => "sites", :action => "edit", 
      #                  :project_id => @project.to_param, :id => @site.to_param)
    end

    it "routes to #create" do
      { :post => sites_path(site.to_param) }
      .should route_to(:controller => "sites", :action => "create", :format => site.to_param)
      # { :post => project_sites_path(@project.to_param) }
      # .should route_to(:controller => "sites", :action => "create", :project_id => @project.to_param)
    end

    it "routes to #update" do
      { :put => site_path(site.to_param) }
      .should route_to(:controller => "sites", :action => "update", :id => site.to_param)
      # { :put => project_site_path(@project.to_param, @site.to_param) }
      # .should route_to(:controller => "sites", :action => "update", 
      #                  :project_id => @project.to_param, :id => @site.to_param)
    end

    it "routes to #destroy" do
      { :delete => site_path(site.to_param) }
      .should route_to(:controller => "sites", :action => "destroy", :id => site.to_param)
      # { :delete => project_site_path(@project.to_param, @site.to_param) }
      # .should route_to(:controller => "sites", :action => "destroy", 
      #                  :project_id => @project.to_param, :id => @site.to_param)
    end
  end
end
