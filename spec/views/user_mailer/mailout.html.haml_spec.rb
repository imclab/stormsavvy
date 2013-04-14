require 'spec_helper'

describe "user_mailer/mailout" do

	before(:all) do
    @greeting = "Greetings"
    @user = FactoryGirl.create(:user)
    @project1 = FactoryGirl.create(
      :project,
      :user => @user,
      :created_at => 1.day.ago
      )
    @project2 = FactoryGirl.create(
      :project,
      :user => @user,
      :created_at => 1.hour.ago
      )
    @projects = [@project1, @project2]

    @site1 = FactoryGirl.create(
      :site,
      :project => @project1,
      :name => 'ec jungle gym',
      :zipcode => 94530
      )
    @site2 = FactoryGirl.create(
      :site,
      :project => @project2,
      :name => 'ec playground slide',
      :zipcode => 94530
      )
    @sites = [@site1, @site2]
  end

  it "renders mailout mailer" do
    render
    rendered.should have_selector 'h1', :text => 'Daily Site POP Alert'
    rendered.should =~ /Daily Site POP Alert/
    rendered.should =~ /Here are your pending reports:/
  end

  it "renders the dashboard partial" do
    render 'dashboard/sidebar'
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
