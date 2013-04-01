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
      @user.projects.blank?.should be_false

      @sites.should == @user.sites.all # nested attribute
      @user.sites.blank?.should be_false

      # @weather_events.should == @site.weather_events.all
    end
  end

  describe "inspection event variables" do
    it "returns inspection events that need attention" do
      @inspection_events.should == @site.inspection_events.where(:completed => false)
    end

    it "does not return inspection event if empty" do
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

    it "does return inspection event if present" do
      ie1 = InspectionEvent.create(:completed => true)
      ie2 = InspectionEvent.create(:completed => true)

      inspection_events = InspectionEvent.completed
      inspection_events.blank?.should == false

      ie = [] << ie1 << ie2
      ie.should == [ie1, ie2]
    end
  end
end
