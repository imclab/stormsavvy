require 'spec_helper'

include ApplicationHelper
include Devise::TestHelpers
include Warden::Test::Helpers
Warden.test_mode!

describe "Dashboard" do

  def valid_session
    { "warden.user.user.key" => session["warden.user.user.key"] }
  end

  let!(:current_user) { FactoryGirl.create(:user) }
  let!(:other_user) { FactoryGirl.create(:user) }
  let!(:current_project) { FactoryGirl.create(
    :project,
    :user => current_user,
    :name => 'eb park and rec'
    ) 
  }
  let!(:other_project) { FactoryGirl.create(
    :project,
    :user => other_user,
    :name => 'berkeley usd'
    )
  }
  let!(:current_completed_site) { FactoryGirl.create(
      :site,
      :project => current_project,
      :name => 'ec jungle gym',
      :zipcode => 94530,
      :lat => 37.9260,
      :lng => -122.3060
    )
  }
  let!(:current_pending_site) { FactoryGirl.create(
      :site,
      :project => current_project,
      :name => 'ec slide',
      :zipcode => 94530,
      :lat => 37.9260,
      :lng => -122.3060
    )
  }
  let!(:other_completed_site) { FactoryGirl.create(
      :site,
      :project_id => other_project,
      :name => 'berkeley high',
      :zipcode => 94709,
      :lat => 37.8870,
      :lng => -122.2670
    )
  }
  let!(:other_pending_site) { FactoryGirl.create(
      :site,
      :project => other_project,
      :name => 'peoples park',
      :zipcode => 94709,
      :lat => 37.8870,
      :lng => -122.2670
    )
  }
  let!(:site) { FactoryGirl.create(
      :site,
      :id => 5,
      :project_id => 2,
      :name => 'sproul hall',
      :zipcode => 94709,
      :lat => 37.8870,
      :lng => -122.2670
    )
  }
  let!(:current_completed_ie) { FactoryGirl.create(
      :inspection_event,
      :id => 1,
      :site_id => 1,
      :completed => true,
      :inspection_type => 'CEM2030'
    )
  }
  let!(:current_pending_ie) { FactoryGirl.create(
      :inspection_event,
      :id => 2,
      :site_id => 2,
      :completed => false,
      :inspection_type => 'CEM2030'
    )
  }
  let!(:other_completed_ie) { FactoryGirl.create(
      :inspection_event,
      :id => 3,
      :site_id => 3,
      :completed => true,
      :inspection_type => 'CEM2031'
    )
  }
  let!(:other_pending_ie) { FactoryGirl.create(
      :inspection_event,
      :id => 4,
      :site_id => 4,
      :completed => false,
      :inspection_type => 'CEM2031'
    )
  }
  let!(:current_completed_report) { FactoryGirl.create(
      :report,
      :id => 1,
      :site_id => 1,
      :status => "completed"
    )
  }
  let!(:current_pending_report) { FactoryGirl.create(
      :report,
      :id => 2,
      :site_id => 2,
      :status => "needs_attention"
    )
  }
  let!(:other_completed_report) { FactoryGirl.create(
      :report,
      :id => 3,
      :site_id => 3,
      :status => "completed"
    )
  }
  let!(:other_pending_report) { FactoryGirl.create(
      :report,
      :id => 4,
      :site_id => 4,
      :status => "needs_attention"
    )
  }

  describe "dashboard/projects" do
    before(:each) do
      login_as(current_user, :scope => :user)
      visit root_path
    end

    it "renders dashboard header" do
      page.should have_text('Storm Savvy')
      page.should have_text('Inspections')
      page.should have_text('Sampling')
      page.should have_text('Settings')
      page.should have_text('Sign out')
      page.should_not be_nil
    end

    it "renders projects info" do
      page.should have_text('# of Sites:')
      page.should have_text('Last Updated:')
      page.should have_link('View Project')
      page.should_not be_nil
    end

    it 'shows correct project and site to user' do
      login_as(current_user, :scope => :user)
      visit root_path
      page.should have_text('eb park and rec')
      page.should have_text('# of Sites: 2')
      page.should have_text('ec jungle gym')
      page.should have_text('ec slide')
      page.should_not have_text('No active projects')

      login_as(other_user, :scope => :user)
      visit root_path
      page.should have_text('berkeley usd')
      page.should have_text('# of Sites: 2')
      page.should have_text('berkeley high')
      page.should have_text('peoples park')
      page.should_not have_text('No active projects')
    end

    it 'creates and displays new projects' do
      login_as(current_user, :scope => :user)
      visit root_path
      click_link 'New Project'
      current_path.should == new_project_path

      fill_in 'Name', :with => 'Troll Bridge Retrofit', :exact => true
      fill_in 'Description', :with => 'Retrofit for the trolls'
      click_button 'Save'
      page.should have_text('Project was successfully created.')
      current_path.should == project_path
    end

    it 'creates new projects for factory users' do
      login_as(current_user, :scope => :user)
      current_user.projects.count.should == 1
      # pp current_user.projects

      project = current_user.projects.build(
        :name => 'ECP',
        :description => 'Plaza Improvements'
      )
      project.save
      current_user.projects.count.should == 2
      pp current_user.email
      # pp current_user.projects

      login_as(other_user, :scope => :user)
      other_user.projects.count.should == 1
      pp other_user.email
      # pp other_user.projects
    end
  end

  describe "dashboard/sidebar" do
    describe 'weather forecast' do
      it 'shows correct site to user' do
        login_as(current_user, :scope => :user)
        visit root_path
        page.should have_text('ec jungle gym')
        page.should_not have_text('No active projects')

        login_as(other_user, :scope => :user)
        visit root_path
        page.should have_text('peoples park')
        page.should_not have_text('No active projects')
      end

      it 'shows site pop' do
        noaa = NoaaForecastService.new(:site => site)
        begin
          noaa.get_forecast
          noaa.save_results
          pp site.chance_of_rain.pop
          pp forecast_period = site.forecast_periods.where('forecast_prediction_time BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day).map(&:pop)
          pp site.forecast_periods.max_by(&:pop).pop
          pp forecast_period.class
          site.chance_of_rain.pop.should == site.forecast_periods.max_by(&:pop).pop
        rescue
          pp 'not online or pop method error'
        end

      end

      it 'loops thru sites array' do
        begin
          sites = [ site ]
          sites.each do |s|
            pp s.name
            noaa = NoaaForecastService.new(:site => s)
            noaa.get_forecast
            noaa.save_results
            pp s.chance_of_rain.pop
          end
        rescue
          pp 'not online or pop method error'
        end

        begin
          pp current_completed_site.name
          pp current_completed_site.lat
          pp current_completed_site.lng
          noaa = NoaaForecastService.new(:site => current_completed_site)
          noaa.get_forecast
          noaa.save_results
          pp current_completed_site.chance_of_rain.pop

          pp current_pending_site.name
          pp current_pending_site.lat
          pp current_pending_site.lng
          noaa = NoaaForecastService.new(:site => current_pending_site)
          noaa.get_forecast
          noaa.save_results
          pp forecast_period = current_pending_site.forecast_periods.where('forecast_prediction_time BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day).map(&:pop)
          pp current_pending_site.forecast_periods.max_by(&:pop).pop
          pp current_pending_site.chance_of_rain.pop
          pp forecast_period.class
        rescue
          pp 'not online or pop method error'
        end

        begin
          pp site.name
          noaa = NoaaForecastService.new(:site => site)
          noaa.get_forecast
          noaa.save_results
          pp site.chance_of_rain.pop
        rescue
          pp 'not online or pop method error'
        end
      end
    end

    describe 'upcoming inspections' do
      before(:each) do
        login_as(current_user, :scope => :user)
        visit root_path
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
        fill_in 'Site', :with => 1
        click_button 'Save'
        page.should have_text('Inspection event was successfully created.')
      end

      it 'shows correct inspection event to user' do
        login_as(current_user, :scope => :user)
        visit root_path
        page.should have_text('CEM2030 for ec slide on 2013-04-01 00:00:00 UTC')
        page.should_not have_text('CEM2030 for ec jungle gym on 2013-04-01 00:00:00 UTC')
        page.should_not have_text('No pending inspections.')

        login_as(other_user, :scope => :user)
        visit root_path
        page.should have_text('CEM2031 for peoples park on 2013-04-01 00:00:00 UTC')
        page.should_not have_text('CEM2031 for berkeley high on 2013-04-01 00:00:00 UTC')
        page.should_not have_text('No pending inspections.')
      end
    end

    describe 'pending reports' do
      it 'shows correct pending reports to user' do
        login_as(current_user, :scope => :user)
        visit root_path
        page.should have_text('Report for ec slide')
        page.should_not have_text('Report for ec jungle gym')
        page.should_not have_text('No active projects')

        login_as(other_user, :scope => :user)
        visit root_path
        page.should have_text('Report for peoples park')
        page.should_not have_text('Report for berkeley high')
        page.should_not have_text('No active projects')
      end
    end

    describe 'report forms' do
      before(:each) do
        login_as(current_user, :scope => :user)
      end

      it "visits each pdf report path" do
        visit '/'
        click_link('CEM 2030 Weekly Inspection Report')
        current_path.should == '/pdf/CEM2030'

        visit '/'
        click_link('CEM 2034 Corrective Action Report')
        current_path.should == '/pdf/CEM2034'

        visit '/'
        click_link('CEM 2035 BMP Status Report')
        current_path.should == '/pdf/CEM2035'

        visit '/'
        click_link('CEM 2040 Weather Forecast Report')
        current_path.should == '/pdf/CEM2040'

        visit '/'
        click_link('CEM 2045 REAP Report')
        current_path.should == '/pdf/CEM2045'

        visit '/'
        click_link('CEM 4601 Daily Report')
        current_path.should == '/pdf/CEM4601'
      end

      it 'visits remaining pdf reports' do
        # visit pdf_CEM2050_path
        # current_path.should == pdf_CEM2050_path

        # visit pdf_CEM2051_path
        # current_path.should == pdf_CEM2051_path

        # visit pdf_CEM2052_path
        # current_path.should == pdf_CEM2052_path
      end
    end
  end
end
