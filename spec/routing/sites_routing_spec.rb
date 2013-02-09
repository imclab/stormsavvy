require "spec_helper"

describe SitesController do

  describe "routing" do
    
    before(:each) do
      attrs = {
        :name => 'Project',
        :description => 'My description',
        :startdate => 5.days.ago,
        :finishdate => 1.day.ago}
      @user = FactoryGirl.create(:user)
      @project = @user.projects.create!(attrs)
      # Stub this later to speed it up...
      @site = @project.sites.create!({:name => 'My site', :zipcode => '94530'})
    end

    it "routes to #index" do
      { :get => project_sites_path(@project.to_param) }
      .should route_to(:controller => "sites", :action => "index", :project_id => @project.to_param)
    end

    it "routes to #new" do
      { :get => new_project_site_path(@project.to_param) }
      .should route_to(:controller => "sites", :action => "new", :project_id => @project.to_param)
    end

    it "routes to #show" do
      { :get => project_site_path(@project.to_param, @site.to_param) }
      .should route_to(:controller => "sites", :action => "show", 
                       :project_id => @project.to_param, :id => @site.to_param)
    end

    it "routes to #edit" do
      { :get => edit_project_site_path(@project.to_param, @site.to_param) }
      .should route_to(:controller => "sites", :action => "edit", 
                       :project_id => @project.to_param, :id => @site.to_param)
    end

    it "routes to #create" do
      { :post => project_sites_path(@project.to_param) }
      .should route_to(:controller => "sites", :action => "create", :project_id => @project.to_param)
    end

    it "routes to #update" do
      { :put => project_site_path(@project.to_param, @site.to_param) }
      .should route_to(:controller => "sites", :action => "update", 
                       :project_id => @project.to_param, :id => @site.to_param)
    end

    it "routes to #destroy" do
      { :delete => project_site_path(@project.to_param, @site.to_param) }
      .should route_to(:controller => "sites", :action => "destroy", 
                       :project_id => @project.to_param, :id => @site.to_param)
    end

  end
end
