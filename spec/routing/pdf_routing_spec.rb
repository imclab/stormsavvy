require "spec_helper"

describe PdfController do

  describe "routing" do
    
    it "routes to #CEM2030" do
      { :get => reports_CEM2030_path }
      .should route_to(:controller => "pdf", :action => "CEM2030")
    end

    it "routes to #CEM2034" do
      { :get => reports_CEM2034_path }
      .should route_to(:controller => "pdf", :action => "CEM2034")
    end

    it "routes to #CEM2035" do
      { :get => reports_CEM2035_path }
      .should route_to(:controller => "pdf", :action => "CEM2035")
    end

    it "routes to #CEM2040" do
      { :get => reports_CEM2040_path }
      .should route_to(:controller => "pdf", :action => "CEM2040")
    end

    it "routes to #CEM2045" do
      { :get => reports_CEM2045_path }
      .should route_to(:controller => "pdf", :action => "CEM2045")
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
      .should route_to(:controller => "pdf", :action => "CEM4601")
    end

  end
end
