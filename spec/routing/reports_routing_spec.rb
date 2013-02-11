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

  describe "pdf/reports routing" do

    it "routes to #CEM2030" do
      { :get => reports_CEM2030_path }
      .should route_to(:controller => "reports", :action => "show", :id => "CEM2030")
    end

    it "routes to #CEM2034" do
      { :get => reports_CEM2034_path }
      .should route_to(:controller => "reports", :action => "show", :id => "CEM2034")
    end

    it "routes to #CEM2035" do
      { :get => reports_CEM2035_path }
      .should route_to(:controller => "reports", :action => "show", :id => "CEM2035")
    end

    it "routes to #CEM2040" do
      { :get => reports_CEM2040_path }
      .should route_to(:controller => "reports", :action => "show", :id => "CEM2040")
    end

    it "routes to #CEM2045" do
      { :get => reports_CEM2045_path }
      .should route_to(:controller => "reports", :action => "show", :id => "CEM2045")
    end

    it "routes to #CEM2050" do
      # { :get => reports_CEM2050_path }
      # .should route_to(:controller => "pdf", :action => "CEM2050")
    end

    it "routes to #CEM2051" do
      # { :get => reports_CEM2051_path }
      # .should route_to(:controller => "pdf", :action => "CEM2051")
    end

    it "routes to #CEM2052" do
      # { :get => reports_CEM2052_path }
      # .should route_to(:controller => "pdf", :action => "CEM2052")
    end

    it "routes to #CEM4601" do
      { :get => reports_CEM4601_path }
      .should route_to(:controller => "reports", :action => "show", :id => "CEM4601")
    end
  end
end
