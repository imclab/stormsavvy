require 'spec_helper'

include ApplicationHelper
include Warden::Test::Helpers
Warden.test_mode!

describe "Dashboard" do
  before(:each) do
    @current_user = FactoryGirl.build(
      :user,
      :id => 1,
      :email => 'name@stormsavvy.com'
    )
    @other_user = FactoryGirl.build(
      :user,
      :id => 2,
      :email => 'info@stormsavvy.com'
    )

    @current_project = FactoryGirl.create(
      :project,
      :id => 1,
      :user_id => 1,
      :name => 'eb park and rec',
      :description => 'playground improvements'
    )
    @other_project = FactoryGirl.create(
      :project,
      :id => 2,
      :user_id => 2,
      :name => 'berkeley usd',
      :description => 'playground improvements'
    )

    @current_site = FactoryGirl.create(
      :site,
      :id => 1,
      :project_id => 1,
      :name => 'ec jungle gym',
      :zipcode => 94530
    )
    @other_site = FactoryGirl.create(
      :site,
      :id => 2,
      :project_id => 2,
      :name => 'berkeley high',
      :zipcode => 94709
    )
    @current_sites = [ @current_site ]
    @other_sites = [ @other_site ]
    @all_sites = [ @current_site, @pending_site ]

    @current_ie = FactoryGirl.create(
      :inspection_event,
      :site_id => 1,
      :completed => false,
      :inspection_type => 'CEM2030'
    )
    @other_ie = FactoryGirl.create(
      :inspection_event,
      :site_id => 2,
      :completed => false,
      :inspection_type => 'CEM2031'
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
  end

  describe "dashboard/projects" do
    before(:each) do
      login_as(@current_user, :scope => :user)
      visit '/'
    end

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

    it 'shows correct project and site to user' do
      login_as(@current_user, :scope => :user)
      visit '/'
      page.should have_text('eb park and rec')
      page.should have_text('# of Sites: 1')
      page.should have_text('ec jungle gym')
      page.should_not have_text('No active projects')

      login_as(@other_user, :scope => :user)
      visit '/'
      page.should have_text('berkeley usd')
      page.should have_text('# of Sites: 1')
      page.should have_text('berkeley high')
      page.should_not have_text('No active projects')
    end
  end

  describe "dashboard/sidebar" do
    before(:each) do
      login_as(@current_user, :scope => :user)
      visit '/'
      click_link 'Inspections'
    end

    it 'displays inspection event title heading' do
      page.should have_text('Site ID')
      page.should have_text('Inspection Type')
      page.should have_text('Inspection Date')
      page.should have_text('Inspected By')
      page.should have_text('Submitted By')
      page.should have_text('Attachment')
    end

    it 'shows correct site to user' do
      login_as(@current_user, :scope => :user)
      visit '/'
      page.should have_text('ec jungle gym')
      page.should_not have_text('No active projects')

      login_as(@other_user, :scope => :user)
      visit '/'
      page.should have_text('berkeley high')
      page.should_not have_text('No active projects')
    end

    it 'creates new inspection event' do
      click_link 'New Inspection Event'
      click_button 'Save'
      page.should have_text('Inspection event was successfully created.')
    end

    it 'shows correct inspection event to user' do
      login_as(@current_user, :scope => :user)
      visit '/'
      page.should have_text('CEM2030 for ec jungle gym on 2013-04-01 00:00:00 UTC')
      page.should_not have_text('No pending inspections.')

      login_as(@other_user, :scope => :user)
      visit '/'
      page.should have_text('CEM2031 for berkeley high on 2013-04-01 00:00:00 UTC')
      page.should_not have_text('No pending inspections.')
    end

    it "displays new report" do
      visit '/'
      page.should have_text('Report for berkeley high')
      page.should_not have_text('No pending reports.')
    end
  end
end
