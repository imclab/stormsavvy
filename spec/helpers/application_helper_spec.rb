require 'spec_helper'

describe ApplicationHelper do

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
  end

  describe '#twitterized_type' do
    it "responds to twitterized_type" do
      helper.should respond_to :twitterized_type
      helper.twitterized_type(:alert).should == "warning"
      helper.twitterized_type(:notice).should == "info"
      helper.twitterized_type(:error).should == "error"
      helper.twitterized_type(:success).should == "success"
    end
  end

  it "has devise login help methods" do
    helper.should respond_to :resource_name
    helper.should respond_to :resource
    helper.should respond_to :devise_mapping
  end

  describe '#resource_name' do
    it "returns user resource" do
      user = self.resource_name
      user.should == :user
    end
  end

  describe '#resource' do
    it 'returns user variable' do
      resource= self.resource
      resource.should == @resource
    end
  end

  describe '#devise_mapping' do
    it 'returns devise variable' do
      devise_mapping = self.devise_mapping
      devise_mapping.should == @devise_mapping
    end
  end

  describe '#projects' do
    it 'returns instance variable' do
      puts @projects
      puts @user.projects

      projects = @user.projects.all
      assign(:projects, projects)
      helper.projects.should == @user.projects.all
    end
  end

  describe '#sites' do
    it 'returns instance variable' do
      sites = @user.sites.all
      assign(:sites, sites)
      helper.sites.should == @user.sites.all
    end
  end

  describe '#weather_events' do
    it 'returns the instance variable' do
      weather_events = WeatherEvent.all
      assign(:weather_event, weather_events)
      helper.weather_events.should == WeatherEvent.all
    end
  end

  describe '#inspection_events' do
    it 'returns the instance variable' do
      inspection_events = InspectionEvent.all
      assign(:inspection_event, inspection_events)
      helper.inspection_events.should == InspectionEvent.all
    end
  end

  describe '#completed_reports' do
    it 'returns the instance variable' do
      completed_reports = Report.completed
      assign(:completed_reports, completed_reports)
      helper.completed_reports.should == Report.completed
    end
  end

  describe '#needs_attention_reports' do
    it 'returns the instance variable' do
      needs_attention_reports = Report.needs_attention
      assign(:needs_attention, needs_attention_reports)
      helper.needs_attention_reports.should == Report.needs_attention
    end
  end
end
