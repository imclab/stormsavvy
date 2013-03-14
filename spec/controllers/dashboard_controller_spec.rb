require 'spec_helper'

describe DashboardController do

  before(:each) do
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
    @inspection_events = [@inspection_event]

    sign_in @user
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

  describe "pig pen variables" do
    it 'returns requested objects' do
      sign_in @user

      @projects.should == @user.projects.all
      @user.projects.empty?.should be_false

      @sites.should == @user.sites.all # nested attribute
      @user.sites.empty?.should be_false

      # @weather_events.should == @site.weather_events.all
      @inspection_events.should == @site.inspection_events.all
    end
  end
end
