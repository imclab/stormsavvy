require 'spec_helper'

describe "dashboard/index" do

  def site_attributes
    { :name => 'Foo bar', :zipcode => '94530' }
  end

  def ie_attributes
    {
      :site_id => 1,
      :inspection_type => "CEM 2030",
      :submitted_by => "wyu",
      :inspected_by => "wyu",
      :completed => false
    }
  end

  before(:each) do
    @user = FactoryGirl.create(:user)
    @p1 = FactoryGirl.create(:project)
    @p2 = FactoryGirl.create(:project)
    @projects = [@p1, @p2]
    @needs_attention_reports = Report.needs_attention
    @s1 = @p1.sites.create(site_attributes)
    @s2 = @p2.sites.create(site_attributes)
    @ie = @s1.inspection_events.create(ie_attributes)
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
      rendered.should =~ /Pending Inspections/
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

    it "does not show completed inspection events" do
      rendered.should_not =~ /CEM 2030 for 2013-03-28 00:00:00 UTC/
    end
  end
end
