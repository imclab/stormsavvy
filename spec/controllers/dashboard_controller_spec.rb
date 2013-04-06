require 'spec_helper'

describe DashboardController do

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

=begin
    # comment back in when model is ready
    @weather_event = FactoryGirl.create(
      :weather_event,
      :site => @site
    )
    @weather_events = [@weather_event]
=end

    @current_ie = FactoryGirl.create(
      :inspection_event,
      :site => @current_site
    )
    @other_ie = FactoryGirl.create(
      :inspection_event,
      :site => @other_site
    )
    @current_ie = [ @current_ie ]
    @pending_ie = [ @pending_ie ]
    @all_ie = [ @current_ie, @pending_ie ]

    @completed_report = FactoryGirl.create(
      :report,
      :site => @site,
      :status => "completed"
    )
    @pending_report = FactoryGirl.create(
      :report,
      :site => @site2,
      :status => "needs_attention"
    )
    @completed_reports = [ @completed_report ]
    @pending_reports = [ @pending_report ]
    @all_reports = [ @completed_report, @pending_report ]

    sign_in @current_user
    sign_in @other_user
  end

  describe "GET 'index' for signed in user" do
    it "returns http success" do
      get :index
      response.should be_success
    end
  end

  describe "GET 'index' for non-signed in user" do
    it "returns http success" do
      sign_out @current_user
      get :index
      response.should redirect_to index_path
    end
  end

  describe "dashboard variables" do
    it 'returns requested objects' do
      sign_in @current_user

      @current_projects.should == @current_user.projects.all
      @current_user.projects.blank?.should be_false

      @current_sites.should == @current_user.sites.all # nested attribute
      @current_user.sites.blank?.should be_false

      # @weather_events.should == @site.weather_events.all
    end

    it "returns inspection events that need attention" do
      @current_ie.should == @current_site.inspection_events.where(:completed => false)
    end
  end

  describe "error handling" do
    let(:site_error) { Site.create(:max_rain => nil) }
    it 'renders error message if rain state = nil' do
      # rendered.should =~ /An error occurred or connection not available./
    end
  end

  describe "dashboard variable states" do
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
      ie1 = InspectionEvent.create(:completed => true)
      ie2 = InspectionEvent.create(:completed => true)

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

  describe "#get_reports" do
    it "returns all reports to current user" do
      sign_in @user
      controller.stub!(:get_reports).and_return(@all_reports)
      @all_reports.should include(@pending_report)
      @all_reports.should include(@completed_report)
      @all_reports.should_not be_nil
    end
  end

  describe "#pending_reports" do
    it "returns pending reports to current user" do
      sign_in @user
      controller.stub!(:get_reports).and_return(@pending_reports)
      @pending_reports.should include(@pending_report)
      @pending_reports.should_not include(@completed_report)
    end
  end

  describe "current_user scope" do
    it "returns correct projects to each user" do
      @user.projects.all.should == @projects
      @user.projects.all.should_not == @projects2
      @user2.projects.all.should == @projects2
      @user2.projects.all.should_not == @projects
    end

    it "returns correct sites to each user" do
      @user.sites.all.should == @sites
      @user.sites.all.should_not == @sites2
      @user2.sites.all.should == @sites2
      @user2.sites.all.should_not == @sites
    end

    it "returns correct inspection_events to each user" do
      @site.inspection_events.all.should == @inspection_events
      @site.inspection_events.all.should_not == @inspection_events2
      @site2.inspection_events.all.should == @inspection_events2
      @site2.inspection_events.all.should_not == @inspection_events
    end

    it "returns correct reports to each user" do
      @site.reports.all.should == @reports
      @site.reports.all.should_not == @reports2
      @site2.reports.all.should == @reports2
      @site2.reports.all.should_not == @reports
    end
  end
end
