require 'spec_helper'

describe "dashboard/index" do

  def site_attributes
    { :name => 'Foo bar', :zipcode => '94530' }
  end

  before(:each) do
    @user = FactoryGirl.create(:user)
    @p1 = FactoryGirl.create(:project)
    @p2 = FactoryGirl.create(:project)
    @projects = [@p1, @p2]
    @needs_attention_reports = Report.needs_attention
    #@s1 = @p1.sites.create(site_attributes)
    #@s2 = @p2.sites.create(site_attributes)
    sign_in @user
    render
  end

  describe "index page components" do

    it "shows active projects to signed in user" do
      # render
      rendered.should have_selector('div#modules')
      view.should render_template('dashboard/_modules')
      rendered.should =~ /Active Projects/
      rendered.should =~ /# of Sites:/
      rendered.should =~ /Last Updated:/
    end

    it "shows sidebar to signed in user" do
      # render
      rendered.should have_selector('div#dashboard-sidebar')
      view.should render_template('dashboard/_sidebar')
    end

    it "shows sidebar with correct titles" do
      # render
      rendered.should have_selector('div#dashboard-sidebar')
      rendered.should =~ /Pending Reports/
      rendered.should =~ /Report Forms/
    end

    it "shows correct report links" do
      # render
      rendered.should have_selector('div#dashboard-sidebar')
      rendered.should =~ /CEM 2030 Weekly Inspection Report/
      rendered.should =~ /CEM 2034 Corrective Action Report/
      rendered.should =~ /CEM 2035 BMP Status Report/
      rendered.should =~ /CEM 2040 Weather Forecast Report/
      rendered.should =~ /CEM 2045 REAP Report/
      rendered.should =~ /CEM 4601 Daily Report/
    end
  end
end
