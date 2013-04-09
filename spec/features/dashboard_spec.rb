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
    # login_as(@other_user, :scope => :user)

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
      :site => @current_site,
      :completed => false
    )
    @other_ie = FactoryGirl.create(
      :inspection_event,
      :site => @other_site,
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
    it "visits homepage" do
      current_path.should == '/'
      page.should_not be_nil
    end

    it "renders projects partial and div tags" do
      page.should have_text('# of Sites:')
      page.should have_text('Last Updated:')
      page.should have_link('View Project')
    end
  end

  describe "dashboard/sidebar" do
    xit "shows weather report" do
      click_link 'Inspections'
      click_button 'New Inspection Event'
      click_button 'Save'
      visit '/'
      page.should have_text('CEM')
    end

    xit "shows pending inspection events" do
      page.should have_text('CEM 2030 for 2013-03-28 00:00:00 UTC')
      page.should_not have_text('No pending inspections.')
    end
  end
end
