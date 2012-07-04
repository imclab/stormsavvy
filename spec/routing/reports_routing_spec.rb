require "spec_helper"

describe ReportsController do

  describe "routing" do


    before(:each) do

      @report = FactoryGirl.create(:report)

      # attrs = {
      #   :name => 'Project',
      #   :description => 'My description',
      #   :startdate => 5.days.ago,
      #   :finishdate => 1.day.ago
      #   }
      # @user = FactoryGirl.create(:user)
      # @project = @user.projects.create!(attrs)
      # @site = @project.sites.create!({:name => 'My site', :zipcode => '94530'})
    end

    it "routes to #index" do
      { :get => reports_path(@report.to_param) }
      .should route_to(:action => "index", :controller => "reports", :format => @report.to_param)
    end

    it "routes to #new" do
      { :get => new_report_path(@report.to_param) }
      .should route_to(:action => "new", :controller => "reports", :format => @report.to_param)
    end

    # it "routes to #new" do
    #   { :get => new_report_path(@report.to_param) }
    #   .should route_to(:controller => "reports", :action => "new", :report_id => @report.to_param)
    # end

    it "routes to #show" do
      { :get => reports_path(@report.to_param) }
      .should route_to(:action => "index", :controller => "reports", :format => @report.to_param)
    end    

    # it "routes to #show" do
    #   { :get => reports_path(@report.to_param) }
    #   .should route_to(:controller => "reports", :action => "show", 
    #                    :report_id => @report.to_param, :id => @report.to_param)
    # end

    it "routes to #edit" do
      { :get => edit_report_path(@report.to_param) }
      .should route_to(:action => "edit", :controller => "reports", :id => @report.to_param)
    end

    # it "routes to #edit" do
    #   { :get => edit_report_path(@report.to_param) }
    #   .should route_to(:controller => "reports", :action => "edit", 
    #                    :report_id => @report.to_param, :id => @report.to_param)
    # end

    it "routes to #create" do
      { :post => reports_path(@report.to_param) }
      .should route_to(:action => "create", :controller => "reports", :format => @report.to_param)
    end

    # it "routes to #create" do
    #   { :post => reports_path(@report.to_param) }
    #   .should route_to(:controller => "reports", :action => "create", :report_id => @report.to_param)
    # end

    it "routes to #update" do
      { :put => report_path(@report.to_param) }
      .should route_to(:action => "update", :controller => "reports", :id => @report.to_param)
    end

    # it "routes to #update" do
    #   { :put => report_path(@report.to_param) }
    #   .should route_to(:controller => "reports", :action => "update", 
    #                    :report_id => @report.to_param, :id => @report.to_param)
    # end

    it "routes to #destroy" do
      { :delete => report_path(@report.to_param) }
      .should route_to(:action => "destroy", :controller => "reports", :id => @report.to_param)
    end

    # it "routes to #destroy" do
    #   { :delete => report_path(@report.to_param) }
    #   .should route_to(:controller => "reports", :action => "destroy", 
    #                    :report_id => @report.to_param, :id => @report.to_param)
    # end

  end
end
