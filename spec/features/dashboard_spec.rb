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

    current_project = FactoryGirl.create(
      :project,
      :id => 1,
      :user_id => 1,
      :name => 'eb park and rec',
      :description => 'playground improvements'
    )
    other_project = FactoryGirl.create(
      :project,
      :id => 2,
      :user_id => 2,
      :name => 'berkeley usd',
      :description => 'playground improvements'
    )

    current_completed_site = FactoryGirl.create(
      :site,
      :id => 1,
      :project_id => 1,
      :name => 'ec jungle gym',
      :zipcode => 94530
    )
    current_pending_site = FactoryGirl.create(
      :site,
      :id => 2,
      :project_id => 1,
      :name => 'ec slide',
      :zipcode => 94530
    )
    other_completed_site = FactoryGirl.create(
      :site,
      :id => 3,
      :project_id => 2,
      :name => 'berkeley high',
      :zipcode => 94709
    )
    other_pending_site = FactoryGirl.create(
      :site,
      :id => 4,
      :project_id => 2,
      :name => 'peoples park',
      :zipcode => 94709
    )

    current_completed_ie = FactoryGirl.create(
      :inspection_event,
      :id => 1,
      :site_id => 1,
      :completed => true,
      :inspection_type => 'CEM2030'
    )
    current_pending_ie = FactoryGirl.create(
      :inspection_event,
      :id => 2,
      :site_id => 2,
      :completed => false,
      :inspection_type => 'CEM2030'
    )
    other_completed_ie = FactoryGirl.create(
      :inspection_event,
      :id => 3,
      :site_id => 3,
      :completed => true,
      :inspection_type => 'CEM2031'
    )
    other_pending_ie = FactoryGirl.create(
      :inspection_event,
      :id => 4,
      :site_id => 4,
      :completed => false,
      :inspection_type => 'CEM2031'
    )

    current_completed_report = FactoryGirl.create(
      :report,
      :id => 1,
      :site_id => 1,
      :status => "completed"
    )
    current_pending_report = FactoryGirl.create(
      :report,
      :id => 2,
      :site_id => 2,
      :status => "needs_attention"
    )
    other_completed_report = FactoryGirl.create(
      :report,
      :id => 3,
      :site_id => 3,
      :status => "completed"
    )
    other_pending_report = FactoryGirl.create(
      :report,
      :id => 4,
      :site_id => 4,
      :status => "needs_attention"
    )
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
      page.should have_text('# of Sites: 2')
      page.should have_text('ec jungle gym')
      page.should_not have_text('No active projects')

      login_as(@other_user, :scope => :user)
      visit '/'
      page.should have_text('berkeley usd')
      page.should have_text('# of Sites: 2')
      page.should have_text('berkeley high')
      page.should_not have_text('No active projects')
    end
  end

  describe "dashboard/sidebar" do
    describe 'weather forecast' do
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
    end

    describe 'upcoming inspections' do
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
    end

    describe 'pending reports' do
      it 'shows correct pending reports to user' do
        login_as(@current_user, :scope => :user)
        visit '/'
        page.should have_text('ec jungle gym')
        page.should_not have_text('No active projects')

        login_as(@other_user, :scope => :user)
        visit '/'
        page.should have_text('berkeley high')
        page.should_not have_text('No active projects')
      end
    end
  end
end
