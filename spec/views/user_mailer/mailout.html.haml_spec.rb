require 'spec_helper'

describe "user_mailer/mailout" do

	before(:all) do
    @greeting = "Greetings"
    @user = FactoryGirl.create(:user)
    @project = FactoryGirl.create(
      :project,
      :user => @user,
      :created_at => 1.day.ago
      )
    @projects = [ @project ]

    @site = FactoryGirl.create(
      :site,
      :project => @project,
      :name => 'ec jungle gym',
      :zipcode => 94530
      )
    @sites = [ @site ]

    @report = FactoryGirl.create(
      :report,
      :site => @site
    )
    @reports = [ @report ]
  end

  it "renders mailout mailer" do
    render
    rendered.should have_selector 'h1', :text => 'Daily Site POP Alert'
    rendered.should =~ /Daily Site POP Alert/
    rendered.should =~ /Here are your pending reports:/
  end

  it "renders pending reports" do
    render
    rendered.should have_text 'Report for'
    rendered.should_not have_text 'No pending reports.'
  end

  it "renders the forecast partial" do
    render 'user_mailer/mailout_forecast'
    rendered.should have_content "Date"
    rendered.should have_content "Forecast"
    # rendered.should have_content "Rainfall"
  end

  it "renders the forecast table" do
    render 'user_mailer/mailout_forecast'
    rendered.should have_selector 'table'
    rendered.should have_selector 'th', :text => "Date"
    rendered.should have_selector 'th', :text => "Forecast"
    # rendered.should have_selector 'th', :text => "Rainfall"
  end
end
