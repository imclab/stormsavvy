require 'spec_helper'

describe "dashboard/index" do

  before(:each) do

    @current_user = FactoryGirl.build(
      :user,
      :email => 'name@stormsavvy.com'
    )
    @other_user = FactoryGirl.build(
      :user,
      :email => 'info@stormsavvy.com'
    )
    @all_users = [ @current_user, @other_user ]

    @current_project = FactoryGirl.create(
      :project,
      :user => @current_user
    )
    @other_project = FactoryGirl.create(
      :project,
      :user => @other_user
    )
    @current_projects = [ @current_project ]
    @other_projects = [ @other_project ]
    @all_project = [ @current_project, @pending_project ]

    @current_site = FactoryGirl.create(
      :site,
      :project => @current_project,
      :name => 'ec jungle gym',
      :zipcode => 94530
    )
    @other_site = FactoryGirl.create(
      :site,
      :project => @other_project,
      :name => 'berkeley high',
      :zipcode => 94709
    )
    @current_sites = [ @current_site ]
    @other_sites = [ @other_site ]
    @all_sites = [ @current_site, @pending_site ]

    @current_ie = FactoryGirl.create(
      :inspection_event,
      :site => @current_site
    )
    @other_ie = FactoryGirl.create(
      :inspection_event,
      :site => @other_site
    )
    @current_ie_array = [ @current_ie ]
    @pending_ie_array = [ @pending_ie ]
    @all_ie_array = [ @current_ie, @pending_ie ]

    @completed_report = FactoryGirl.create(
      :report,
      :site => @current_site,
      :status => "completed"
    )
    @pending_report = FactoryGirl.create(
      :report,
      :site => @other_site,
      :status => "needs_attention"
    )
    @completed_reports = [ @completed_report ]
    @pending_reports = [ @pending_report ]
    @all_reports = [ @completed_report, @pending_report ]

    controller.stub(:current_user) { @current_user }

    sign_in @current_user
    sign_in @other_user

    render
  end

  describe "index page components" do

    it "renders index partial and div tags" do
      view.should render_template('dashboard/index')
      view.should render_template('dashboard/_modules')
      view.should render_template('dashboard/_sidebar')
    end

    it "renders module partial and div tags" do
      view.should render_template('dashboard/_modules')
      rendered.should have_selector('div#modules')
    end

    it "renders modules with correct text and links" do
      rendered.should =~ /Active Projects/
      rendered.should have_link('New Project')
    end

    it "renders projects partial and div tags" do
      view.stub(:projects)
      view.should render_template('dashboard/_projects')
      rendered.should have_text('# of Sites:')
      rendered.should have_text('Last Updated:')
    end

    it "renders sidebar partial and div tags" do
      rendered.should have_selector('div#dashboard-sidebar')
      rendered.should have_selector('div#current_weather')
      rendered.should have_selector('div#current_action_items')
      rendered.should have_selector('div#current_daily_diary')
    end

    it "shows sidebar with correct titles" do
      rendered.should =~ /Weather Report/
      rendered.should =~ /Pending Inspections/
      rendered.should =~ /Pending Reports/
      rendered.should =~ /Report Forms/
    end

    it "shows correct report links" do
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
      rendered.should =~ /No pending inspections./
    end
  end
end
