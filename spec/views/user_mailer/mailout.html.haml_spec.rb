require 'spec_helper'

describe "user_mailer/mailout" do

	before(:all) do
    @greeting = "Greetings"
=begin
    @forecast1 = [{ :date => Date.today + 0.day, :weather => "90" },
                  { :date => Date.today + 1.day, :weather => "85"},
                  { :date => Date.today + 2.day, :weather => "80"},
                  { :date => Date.today + 3.day, :weather => "75"},
                  { :date => Date.today + 4.day, :weather => "70"},
                  { :date => Date.today + 5.day, :weather => "65"},
                  { :date => Date.today + 6.day, :weather => "60"}]
    @date1 = Date.today + 0.day
    @date2 = Date.today + 1.day
    @date3 = Date.today + 2.day
    @date4 = Date.today + 3.day
    @date5 = Date.today + 4.day
    @date6 = Date.today + 5.day
    @date7 = Date.today + 6.day
=end
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

  it "renders the forecast partial" do
    render 'user_mailer/mailout_forecast'
    rendered.should have_content "Date"
    rendered.should have_content "Forecast"
    # rendered.should have_content "Rainfall"
  end

  it "contains a forecast table" do
    render 'user_mailer/mailout_forecast'
    rendered.should have_selector 'table'
    rendered.should have_selector 'th', :text => "Date"
    rendered.should have_selector 'th', :text => "Forecast"
    # rendered.should have_selector 'th', :text => "Rainfall"
  end

  it "renders date with data" do
    render 'user_mailer/mailout_forecast'
    rendered.should have_content ProjectLocalTime::format(@date1)
    rendered.should have_content ProjectLocalTime::format(@date2)
    rendered.should have_content ProjectLocalTime::format(@date3)
    rendered.should have_content ProjectLocalTime::format(@date4)
    rendered.should have_content ProjectLocalTime::format(@date5)
    rendered.should have_content ProjectLocalTime::format(@date6)
    rendered.should have_content ProjectLocalTime::format(@date7)

    # rendered.should have_content "90"
    # rendered.should have_content "85"
    # rendered.should have_content "80"
    # rendered.should have_content "75"
    # rendered.should have_content "70"
    # rendered.should have_content "65"
    # rendered.should have_content "60"

    # rendered.should have_content "0"
    # rendered.should have_content "1"
    # rendered.should have_content "2"
    # rendered.should have_content "3"
    # rendered.should have_content "4"
    # rendered.should have_content "5"
    # rendered.should have_content "6"
  end
end
