require 'spec_helper'

include ApplicationHelper
include Warden::Test::Helpers
Warden.test_mode!

describe "Dashboards" do
  before(:each) do
    @current_user = FactoryGirl.build(
      :user,
      :email => 'name@stormsavvy.com'
    )
    login_as(@current_user, :scope => :user)

    @other_user = FactoryGirl.build(
      :user,
      :email => 'info@stormsavvy.com'
    )
    login_as(@other_user, :scope => :user)

    @all_users = [ @current_user, @other_user ]

    @current_project = FactoryGirl.create(
      :project,
      :user => @current_user,
      :name => 'eb park and rec',
      :description => 'playground improvements'
    )
    @other_project = FactoryGirl.create(
      :project,
      :user => @other_user,
      :name => 'eb park and rec',
      :description => 'playground improvements'
    )
    @current_projects = [ @current_project ]
    @other_projects = [ @other_project ]
    @all_project = [ @current_project, @pending_project ]

    @current_site = FactoryGirl.create(
      :site,
      :id => 1,
      :project => @current_project,
      :name => 'ec jungle gym',
      :zipcode => 94530
    )
    @other_site = FactoryGirl.create(
      :site,
      :id => 2,
      :project => @other_project,
      :name => 'berkeley high',
      :zipcode => 94709
    )
    @current_sites = [ @current_site ]
    @other_sites = [ @other_site ]
    @all_sites = [ @current_site, @pending_site ]

    @current_ie = FactoryGirl.create(
      :inspection_event,
      :site_id => 1,
      # :site => @current_site,
      :completed => false
    )
    @other_ie = FactoryGirl.create(
      :inspection_event,
      :site_id => 2,
      # :site => @other_site,
      :completed => false
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

    visit '/'
  end

  describe "dashboard/projects" do
    it "renders dashboard" do
      current_path.should == '/'
      page.should have_text('Storm Savvy')
      page.should have_text('Inspections')
      page.should have_text('Sampling')
      page.should have_text('Settings')
      page.should have_text('Sign out')
      page.should_not be_nil
    end

    it "renders projects partial and div tags" do
      page.should have_text('# of Sites:')
      page.should have_text('Last Updated:')
      page.should have_link('View Project')
      page.should_not be_nil
    end
  end

  describe "dashboard/sidebar" do
    it "creates new inspection event" do
      click_link 'Inspections'
      page.should have_text('Site ID')
      page.should have_text('Inspection Type')
      page.should have_text('Inspection Date')
      page.should have_text('Inspected By')
      page.should have_text('Submitted By')
      page.should have_text('Attachment')

      click_link 'New Inspection Event'
      click_button 'Save'
      page.should have_text('Inspection event was successfully created.')

      visit '/'
      page.should have_text('UTC')
      page.should have_text('weekly for 2013-04-01 00:00:00 UTC')
      page.should_not have_text('No pending inspections.')
    end
  end

  describe "dashboard/sidebar" do
    it "creates new report" do
      # visit '/reports'
      # page.should have_text('')

      # click_link 'New Report'
      # page.should have_text('Report was successfully created.')

      visit '/'
      page.should have_text('Report for berkeley high')
      page.should_not have_text('No pending reports.')
    end
  end
end
