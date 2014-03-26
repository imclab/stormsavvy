require 'spec_helper'
require 'current_user_object'

describe DashboardController do

  include Devise::TestHelpers

  let!(:user) {
    FactoryGirl.create(:user)
    # login_as(user, :scope => :user)
  }
  let!(:current_user) { FactoryGirl.create(
    :user,
    email: 'name@stormsavvy.com'
  )}
  let!(:other_user) { FactoryGirl.create(
    :user,
    email: 'info@stormsavvy.com'
  )}
  let!(:all_users) { [ @current_user, @other_user ] }

  let!(:current_site) { FactoryGirl.create(
    :site,
    user: current_user,
    name: 'ec jungle gym',
    zipcode: 94530
  )}
  let!(:other_site) { FactoryGirl.create(
    :site,
    user: other_user,
    name: 'berkeley high',
    zipcode: 94709
  )}
  let!(:current_sites) { [ current_site ] }
  let!(:other_sites) { [ other_site ] }
  let!(:all_sites) { [ current_site, other_site ] }

  let!(:current_ie) { FactoryGirl.create(
    :inspection_event,
    site: current_site
  )}
  let!(:other_ie) { FactoryGirl.create(
    :inspection_event,
    site: other_site
  )}
  let!(:current_ie_array) { [ current_ie ] }
  let!(:other_ie_array) { [ other_ie ] }
  let!(:all_ie_array) { [ current_ie, other_ie ] }

  let!(:completed_report) { FactoryGirl.create(
    :report,
    site: current_site,
    status: 'completed'
  )}
  let!(:pending_report) { FactoryGirl.create(
    :report,
    site: current_site,
    status: 'needs_attention'
  )}
  let!(:other_report) { FactoryGirl.create(
    :report,
    site: other_site,
    status: 'needs_attention'
  )}
  let!(:completed_reports) { [ completed_report ] }
  let!(:pending_reports) { [ pending_report ] }
  let!(:all_reports) { [ completed_report, pending_report ] }

  before(:each) do
    sign_in current_user
    sign_in other_user
    sign_in user
  end

  describe "GET 'index' for signed in user" do
    it "returns http success" do
      get :index
      response.should be_success
    end
  end

  describe "dashboard variables: users and sites" do
    it 'returns current sites' do
      # sign_in @current_user
      current_sites.should == current_user.sites
      current_sites.should_not include(other_sites)
      current_sites.should_not be_nil
    end

    it "returns pending inspection events" do
      current_ie_array.should == current_site.inspection_events.where(completed: false)
      current_ie_array.should_not include(other_ie)
    end
  end

  describe "dashboard variables: events and reports" do
    it "does not return inspection event if empty to current user" do
      inspection_events = []
      current_user.sites.each do |site|
        site.inspection_events.each do |ie|
          if ie.completed.blank?
            pp 'no inspection events'
          else
            inspection_events[] << ie.completed
            pp ie.completed
          end
        end
      end

      inspection_events.should == current_site.inspection_events.completed
    end

    it "returns inspection event if present to current user" do
      current_ie = InspectionEvent.create(
        site: current_site,
        site_id: current_site.object_id,
        completed: true
      )
      other_ie = InspectionEvent.create(
        site: other_site,
        site_id: other_site.object_id,
        completed: true
      )

      inspection_events = InspectionEvent.completed
      inspection_events.blank?.should == false

      ie = [] << current_ie << other_ie
      ie.should == [current_ie, other_ie]
    end

    it "returns needs_attention reports" do
      FactoryGirl.create(
        :report,
        status: 'needs_attention'
      )
      needs_attention = Report.where(status: 'needs_attention')
      needs_attention.blank?.should == false
    end

    it "returns completed reports" do
      FactoryGirl.create(
        :report,
        status: 'completed'
      )
      completed = Report.where(status: 'completed')
      completed.blank?.should == false
    end
  end

  describe "error handling" do
    let(:site_error) { Site.create(max_rain: nil) }
    it 'renders error message if rain state = nil' do
      # rendered.should =~ /An error occurred or connection not available./
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
      @current_site.reports.should include(@pending_report)
      @current_site.reports.should_not include(@other_report)
    end

    it 'returns reports from lib class' do
      cu = CurrentUserObject.new
      reports = cu.pending_reports(@current_user)
      reports.should == @pending_reports
      reports.should_not include(@completed_report)
    end
  end
end
