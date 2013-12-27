require 'spec_helper'

describe DashboardController do

  include Devise::TestHelpers

  let(:user) {
    FactoryGirl.create(:user)
    # login_as(user, :scope => :user)
  }

  before :each do
    sign_in user
  end

  before(:each) do
    @current_user = FactoryGirl.create(
      :user,
      :email => 'name@stormsavvy.com'
    )
    @other_user = FactoryGirl.create(
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
      :user => @current_user,
      # :project => @current_project,
      :name => 'ec jungle gym',
      :zipcode => 94530
    )
    @other_site = FactoryGirl.create(
      :site,
      :user => @other_user,
      # :project => @other_project,
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
    @other_report = FactoryGirl.create(
      :report,
      :site => @other_site,
      :status => "needs_attention"
    )
    @completed_reports = [ @completed_report ]
    @pending_reports = [ @pending_report ]
    @all_reports = [ @completed_report, @pending_report ]

    sign_in @current_user
    sign_in @other_user
    sign_in user

    # @weather_event = FactoryGirl.create(:weather_event, :site => @site)
    # @weather_events = [@weather_event]
  end

  describe "GET 'index' for signed in user" do
    it "returns http success" do
      get :index
      response.should be_success
    end
  end

  describe "dashboard variables: users, projects and sites" do
    it 'returns current projects and sites' do
      # sign_in @current_user
      @current_projects.should == @current_user.projects
      @current_projects.should_not include(@other_projects)
      @current_projects.should_not be_nil

      @current_sites.should == @current_user.sites
      @current_sites.should_not include(@other_sites)
      @current_sites.should_not be_nil
    end

    it "returns pending inspection events" do
      @current_ie_array.should == @current_site.inspection_events.where(:completed => false)
      @current_ie_array.should_not include(@other_ie)
    end
  end

  describe "dashboard variables: events and reports" do
    it "does not return inspection event if empty to current user" do
      inspection_events = []
      @current_user.sites.each do |site|
        site.inspection_events.each do |ie|
          if ie.completed.blank?
            puts 'no inspection events'
          else
            inspection_events[] << ie.completed
            puts ie.completed
          end
        end
      end

      inspection_events.should == @current_site.inspection_events.completed
    end

    it "returns inspection event if present to current user" do
      ie1 = InspectionEvent.create(
        :site => @current_site,
        :site_id => @current_site.object_id,
        :completed => true
      )
      ie2 = InspectionEvent.create(
        :site => @other_site,
        :site_id => @other_site.object_id,
        :completed => true
      )

      inspection_events = InspectionEvent.completed
      inspection_events.blank?.should == false

      ie = [] << ie1 << ie2
      ie.should == [ie1, ie2]
    end

    it "returns needs_attention reports" do
      Report.create(:status => "needs_attention")
      needs_attention = Report.where(:status => "needs_attention")
      needs_attention.blank?.should == false
    end

    it "returns completed reports" do
      Report.create(:status => "completed")
      completed = Report.where(:status => "completed")
      completed.blank?.should == false
    end
  end

  describe "error handling" do
    let(:site_error) { Site.create(:max_rain => nil) }
    it 'renders error message if rain state = nil' do
      # rendered.should =~ /An error occurred or connection not available./
    end
  end

  describe "#get_projects" do
    it "returns all projects to current user" do
      # sign_in @current_user
      controller.stub(:get_projects).and_return(@all_projects)
      @all_projects.should include(@current_project)
      @all_projects.should include(@other_project)
      @all_projects.should_not be_nil
    end

    it "returns correct projects to each user" do
      @current_user.projects.should == @current_projects
      @current_user.projects.should_not == @other_projects
      @current_projects.should_not be_nil

      @other_user.projects.should == @other_projects
      @other_user.projects.should_not == @current_projects
      @other_projects.should_not be_nil
    end

    it 'returns projects from lib class' do
      cu = CurrentUserObject.new
      projects = cu.get_projects(@current_user)
      projects.should == @current_projects
    end
  end

  describe "#get_sites" do
    it "returns all sites to current user" do
      # sign_in @current_user
      controller.stub(:get_sites).and_return(@all_sites)
      @all_sites.should include(@current_site)
      @all_sites.should include(@other_site)
      @all_sites.should_not be_nil
    end

    it "returns correct sites to each user" do
      @current_user.sites.should == @current_sites
      @current_user.sites.should_not == @other_sites
      @current_sites.should_not be_nil

      @other_user.sites.should == @other_sites
      @other_user.sites.should_not == @current_sites
      @other_sites.should_not be_nil
    end

    it 'returns sites from lib class' do
      cu = CurrentUserObject.new
      sites = cu.get_sites(@current_user)
      sites.should == @current_sites
    end
  end

  describe "#get_ie" do
    it "returns all reports to current user" do
      # sign_in @current_user
      controller.stub(:get_ie).and_return(@all_ie_array)
      @all_ie_array.should include(@current_ie)
      @all_ie_array.should include(@other_ie)
      @all_ie_array.should_not be_nil
    end

    it "returns correct inspection_events to each user" do
      @current_site.inspection_events.should == @current_ie_array
      @current_site.inspection_events.should_not == @other_ie_array
      @other_site.inspection_events.should == @other_ie_array
      @other_site.inspection_events.should_not == @current_ie_array
    end

    it 'returns pending ie from lib class' do
      cu = CurrentUserObject.new
      ie = cu.get_ie(@current_user)
      ie.should == @current_ie_array
    end
  end

  describe "#get_reports" do
    it "returns all reports to current user" do
      # sign_in @current_user
      controller.stub(:get_reports).and_return(@all_reports)
      @all_reports.should include(@pending_report)
      @all_reports.should include(@completed_report)
      @all_reports.should_not be_nil
    end

    it 'returns reports from lib class' do
      cu = CurrentUserObject.new
      reports = cu.get_reports(@current_user)
      reports.should == @all_reports
    end
  end

  describe "#pending_reports" do
    it "returns pending reports to current user" do
      # sign_in @current_user
      controller.stub(:pending_reports).and_return(@pending_reports)
      @pending_reports.should include(@pending_report)
      @pending_reports.should_not include(@completed_report)
    end

    it "returns correct reports to each user" do
      # sign_in @current_user
      controller.stub(:pending_reports).and_return(@pending_reports)
      @current_site.reports.all.should include(@pending_report)
      @current_site.reports.all.should_not include(@other_report)
    end

    it 'returns reports from lib class' do
      cu = CurrentUserObject.new
      reports = cu.pending_reports(@current_user)
      reports.should == @pending_reports
      reports.should_not include(@completed_report)
    end
  end
end
