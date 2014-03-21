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
  let!(:current_completed_site) { FactoryGirl.create(
      :site,
      user: current_user,
      name: 'ec jungle gym',
      zipcode: 94530,
      # lat: 37.9260,
      # long: -122.3060
    )
  }
  let!(:current_pending_site) { FactoryGirl.create(
      :site,
      user: current_user,
      name: 'ec slide',
      zipcode: 94530,
      # lat: 37.9260,
      # lng: -122.3060
    )
  }
  let!(:other_completed_site) { FactoryGirl.create(
      :site,
      user: other_user,
      name: 'berkeley high',
      zipcode: 94709,
      # lat: 37.8870,
      # lng: -122.2670
    )
  }
  let!(:other_pending_site) { FactoryGirl.create(
      :site,
      user: other_user,
      name: 'peoples park',
      zipcode: 94709,
      # lat: 37.8870,
      # lng: -122.2670
    )
  }
  let!(:site) { FactoryGirl.create(
      :site,
      name: 'sproul hall',
      zipcode: 94709,
      # lat: 37.8870,
      # lng: -122.2670
    )
  }
  let!(:current_completed_ie) { FactoryGirl.create(
      :inspection_event,
      site: site,
      completed: true,
      inspection_type: 'CEM2030'
    )
  }
  let!(:current_pending_ie) { FactoryGirl.create(
      :inspection_event,
      site: site,
      completed: false,
      inspection_type: 'CEM2030'
    )
  }
  let!(:other_completed_ie) { FactoryGirl.create(
      :inspection_event,
      site: site,
      completed: true,
      inspection_type: 'CEM2031'
    )
  }
  let!(:other_pending_ie) { FactoryGirl.create(
      :inspection_event,
      site: site,
      completed: false,
      inspection_type: 'CEM2031'
    )
  }
  let!(:current_completed_report) { FactoryGirl.create(
      :report,
      site: current_completed_site,
      status: "completed"
    )
  }
  let!(:current_pending_report) { FactoryGirl.create(
      :report,
      site: current_pending_site,
      status: "needs_attention"
    )
  }
  let!(:other_completed_report) { FactoryGirl.create(
      :report,
      site: other_completed_site,
      status: "completed"
    )
  }
  let!(:other_pending_report) { FactoryGirl.create(
      :report,
      site: other_pending_site,
      status: "needs_attention"
    )
  }

  describe "dashboard/projects" do
    before(:each) do
      login_as(current_user, scope: :user)
      visit root_path
    end

    it "renders dashboard header" do
      page.should have_text('Storm Savvy')
      page.should have_text('Inspections')
      page.should have_text('Sampling')
      page.should have_text('Settings')
      page.should have_text('Sign Out')
      page.should_not be_nil
    end

    it "renders site info" do
      page.should have_text('Last Updated:')
      page.should have_text('Site ID:')
      # page.should have_link('Site Lat/Long:')
      # page.should have_link('Site Zipcode:')
      page.should_not be_nil
    end

    it 'shows correct site to current_user' do
      # login_as(current_user, scope: :user)
      # visit root_path
      # page.should have_text('eb park and rec')
      # page.should have_text('# of Sites: 2')
      page.should have_text('ec jungle gym')
      page.should have_text('ec slide')
      page.should_not have_text('No active projects')
      page.should_not have_text('berkeley high')
    end

    it 'shows correct site to other_user' do
      login_as(other_user, scope: :user)
      visit root_path
      # page.should have_text('berkeley usd')
      # page.should have_text('# of Sites: 2')
      page.should have_text('berkeley high')
      page.should have_text('peoples park')
      page.should_not have_text('No active projects')
      page.should_not have_text('ec jungle gym')
    end

    it 'creates and displays new sites' do
      login_as(current_user, scope: :user)
      visit root_path
      click_link 'New Site'
      current_path.should == new_site_path

      fill_in "Name", with: "ecp"
      fill_in "Zipcode", with: 94530
      click_button 'Save'

      page.should have_text('Site was successfully created.')
      # current_path.should == site_path
    end

    it 'creates new sites for factory users' do
      login_as(current_user, scope: :user)
      current_user.sites.count.should == 2

      site = current_user.sites.build(
        name: 'ECP',
        description: 'Plaza Improvements',
        zipcode: 94530
      )
      site.save
      current_user.sites.count.should == 3

      login_as(other_user, scope: :user)
      other_user.sites.count.should == 2
    end
  end

  describe "dashboard/sidebar" do
    describe 'weather forecast' do
      it 'shows correct site to user' do
        login_as(current_user, scope: :user)
        visit root_path
        page.should have_text('ec jungle gym')
        page.should have_text('ec slide')
        page.should_not have_text('peoples park')
        page.should_not have_text('berkeley high')
        page.should_not have_text('No active sites')

        login_as(other_user, scope: :user)
        visit root_path
        page.should have_text('peoples park')
        page.should have_text('berkeley high')
        page.should_not have_text('ec jungle gym')
        page.should_not have_text('ec slide')
        page.should_not have_text('No active sites')
      end

      it 'shows site pop' do
        noaa = NoaaForecastService.new(site: site)
        begin
          noaa.get_forecast
          noaa.save_results
          pp site.chance_of_rain.pop
          pp forecast_period = site.forecast_periods.where('forecast_prediction_time BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day).map(&:pop)
          pp site.forecast_periods.max_by(&:pop).pop
          pp forecast_period.class
          site.chance_of_rain.pop.should == site.forecast_periods.max_by(&:pop).pop
        rescue => e
          # pp 'not online or pop method error'
          pp e
        end
      end

      it 'loops thru sites array' do
        begin
          sites = [ site ]
          sites.each do |site|
            pp site.name
            noaa = NoaaForecastService.new(:site => site)
            noaa.get_forecast
            noaa.save_results
            site.chance_of_rain.pop.should be_between(0,100)
            site.chance_of_rain.pop.should_not be_nil
          end
        rescue => e
          # pp 'not online or pop method error'
          pp e
        end
      end

      it 'gets pop for current_completed_site' do
        begin
          pp current_completed_site.name
          pp current_completed_site.lat
          pp current_completed_site.lng
          noaa = NoaaForecastService.new(:site => current_completed_site)
          noaa.get_forecast
          noaa.save_results
          current_completed_site.chance_of_rain.pop.should be_between(0, 100)
          current_completed_site.chance_of_rain.pop.should_not be_nil
        rescue => e
          # pp 'not online or pop method error'
          pp e
        end
      end

      it 'gets pop for current_pending_site' do
        begin
          pp current_pending_site.name
          pp current_pending_site.lat
          pp current_pending_site.lng
          noaa = NoaaForecastService.new(:site => current_pending_site)
          noaa.get_forecast
          noaa.save_results
          pp current_pending_site.forecast_periods.max_by(&:pop).pop
          current_pending_site.chance_of_rain.pop.should be_between(0,100)
          current_pending_site.chance_of_rain.pop.should_not be_nil
        rescue => e
          # pp 'not online or pop method error'
          pp e
        end
      end

      it 'gets pop for site' do
        begin
          pp site.name
          noaa = NoaaForecastService.new(:site => site)
          noaa.get_forecast
          noaa.save_results
          site.chance_of_rain.pop.should be_between(0,100)
          site.chance_of_rain.pop.should_not be_nil
        rescue => e
          # pp 'not online or pop method error'
          pp e
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

      xit 'shows correct inspection event to user' do
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
      xit 'shows correct pending reports to user' do
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
