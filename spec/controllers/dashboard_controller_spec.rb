require 'spec_helper'

describe DashboardController do

  before(:each) do
    @user = FactoryGirl.build(
      :user,
      :email => 'name@stormsavvy.com'
    )
    @user2 = FactoryGirl.build(
      :user,
      :email => 'info@stormsavvy.com'
    )
    @users = [ @user ]

    @project = FactoryGirl.create(
      :project,
      :user => @user
    )
    @project2 = FactoryGirl.create(
      :project,
      :user => @user2
    )
    @projects = [ @project ]
    @projects2 = [ @project2 ]

    @site = FactoryGirl.create(
      :site,
      :project => @project,
      :name => 'ec jungle gym',
      :zipcode => 94530
    )
    @site2 = FactoryGirl.create(
      :site,
      :project => @project2,
      :name => 'berkeley high',
      :zipcode => 94709
    )
    @sites = [ @site ]
    @sites2 = [ @site2 ]

=begin
    # comment back in when model is ready
    @weather_event = FactoryGirl.create(
      :weather_event,
      :site => @site
    )
    @weather_events = [@weather_event]
=end

    @inspection_event = FactoryGirl.create(
      :inspection_event,
      :site => @site
    )
    @inspection_event2 = FactoryGirl.create(
      :inspection_event,
      :site => @site2
    )
    @inspection_events = [ @inspection_event ]
    @inspection_events2 = [ @inspection_event2 ]

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

    sign_in @user
    sign_in @user2
  end

  describe "GET 'index' for signed in user" do
    it "returns http success" do
      get :index
      response.should be_success
    end
  end

  describe "GET 'index' for non-signed in user" do
    it "returns http success" do
      sign_out @user
      get :index
      response.should redirect_to index_path
    end
  end

  describe "dashboard variables" do
    it 'returns requested objects' do
      sign_in @user

      @projects.should == @user.projects.all
      @user.projects.blank?.should be_false

      @sites.should == @user.sites.all # nested attribute
      @user.sites.blank?.should be_false

      # @weather_events.should == @site.weather_events.all
    end

    it "returns inspection events that need attention" do
      @inspection_events.should == @site.inspection_events.where(:completed => false)
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
      @user.sites.each do |site|
        site.inspection_events.each do |ie|
          if ie.completed.blank?
            puts 'no inspection events'
          else
            inspection_events[] << ie.completed
            puts ie.completed
          end
        end
      end

      inspection_events.should == @site.inspection_events.completed
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
