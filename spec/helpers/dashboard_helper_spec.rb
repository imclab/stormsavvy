require 'spec_helper'
require 'current_user_object'

describe DashboardHelper do

  before(:each) do
    @fullcount = 29
    @zipcode = 94530
    @lat = 37.9202057
    @long = -122.2937428

    @nf = double(NOAAForecast)
    @nf2 = NOAAForecast.new(@zipcode,168,6)
    @pop = @nf2.pop
    @qpf = @nf2.qpf

    @user = FactoryGirl.create(:user)
    @project = FactoryGirl.create(
      :project,
      :user => @user,
      :created_at => 1.day.ago
    )
    @projects = [@project]

    @site = FactoryGirl.create(
      :site,
      :project => @project,
      :name => 'ec jungle gym',
      :zipcode => 94530
    )
    @sites = [@site]

    @ie = FactoryGirl.create(
      :inspection_event,
      :site => @site
    )

    @se = FactoryGirl.create(
      :sampling_event,
      :site => @site
    )

    # factories for instance variable method spec
    @current_user = FactoryGirl.build(
      :user,
      :email => '@stormsavvy.com'
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
    @all_projects = [ @current_project, @other_project ]

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
    @all_sites = [ @current_site, @other_site ]

    @current_ie = FactoryGirl.create(
      :inspection_event,
      :site => @current_site
    )
    @other_ie = FactoryGirl.create(
      :inspection_event,
      :site => @other_site
    )
    @current_ie_array = [ @current_ie ]
    @other_ie_array = [ @other_ie ]
    @all_ie_array = [ @current_ie, @other_ie ]

    @completed_report = FactoryGirl.create(
      :report,
      :site => @current_site,
      :status => "completed"
    )
    @pending_report = FactoryGirl.create(
      :report,
      :site => @current_site,
      :status => "needs_attention"
    )
    @completed_reports = [ @completed_report ]
    @pending_reports = [ @pending_report ]
    @all_reports = [ @completed_report, @pending_report ]
  end

  describe '#chance_of_rain' do
    it "returns @max_rain" do
      zipcode = 94530
      @nf2.seven_day_weather(zipcode)

      # where is method called in noaa forecast?
      # @max_rain = nf.noaa_forecast[0][0..4].max
    end
  end

  describe '#precipitation_state' do
    it "returns @rain_state" do
=begin
      # spec out later
      if forecast == [[],[]]
        @rain_state = :null
        return
      end
      fe = ForecastExaminer.new(forecast)
      fe.find_rain_chance()
      @rain_state = fe.rain
=end
    end
  end

  describe "#get_projects" do
    it "returns all projects to current user" do
      @all_projects.should include(@current_project)
      @all_projects.should include(@other_project)
      @all_projects.should_not be_nil
    end

    it "returns correct projects to each user" do
      @current_user.projects.all.should == @current_projects
      @current_user.projects.all.should_not == @other_projects
      @other_user.projects.all.should == @other_projects
      @other_user.projects.all.should_not == @current_projects
    end

    xit 'returns correct projects from lib class' do
      # fix this...
      projects = CurrentUserObject::get_projects
      projects.should == @current_projects
    end
  end

  describe "#get_sites" do
    it "returns all sites to current user" do
      @all_sites.should include(@current_site)
      @all_sites.should include(@other_site)
      @all_sites.should_not be_nil
    end

    it "returns correct sites to each user" do
      @current_user.sites.all.should == @current_sites
      @current_user.sites.all.should_not == @other_sites
      @other_user.sites.all.should == @other_sites
      @other_user.sites.all.should_not == @current_sites
    end
  end

  describe "#get_ie" do
    it "returns all reports to current user" do
      @all_ie_array.should include(@current_ie)
      @all_ie_array.should include(@other_ie)
      @all_ie_array.should_not be_nil
    end

    it "returns correct inspection_events to each user" do
      @current_site.inspection_events.all.should == @current_ie_array
      @current_site.inspection_events.all.should_not == @other_ie_array
      @other_site.inspection_events.all.should == @other_ie_array
      @other_site.inspection_events.all.should_not == @current_ie_array
    end
  end

  describe "#get_reports" do
    it "returns all reports to current user" do
      @all_reports.should include(@pending_report)
      @all_reports.should include(@completed_report)
      @all_reports.should_not be_nil
    end
  end

  describe "#pending_reports" do
    it "returns pending reports to current user" do
      @pending_reports.should include(@pending_report)
      @pending_reports.should_not include(@completed_report)
    end

    it "returns correct reports to each user" do
      # @current_site.reports.all.should == @pending_reports
      # @current_site.reports.all.should_not == @completed_reports
      # @other_site.reports.all.should == @other_reports
      # @other_site.reports.all.should_not == @current_reports
    end
  end
end
