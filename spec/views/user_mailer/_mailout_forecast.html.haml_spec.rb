require 'spec_helper'

describe "user_mailer/_mailout_forecast" do

  before(:each) do
    @receipient = "walter@stormsavvy.com"
    @mailer = UserMailer.mailout
    @greeting = "Greetings"

    @forecast = [
      { :date => Date.today + 0.day, :weather => "90" },
      { :date => Date.today + 1.day, :weather => "85"},
      { :date => Date.today + 2.day, :weather => "80"},
      { :date => Date.today + 3.day, :weather => "75"},
      { :date => Date.today + 4.day, :weather => "70"},
      { :date => Date.today + 5.day, :weather => "65"},
      { :date => Date.today + 6.day, :weather => "60"}
    ]
    @date1 = Date.today + 0.day
    @date2 = Date.today + 1.day
    @date3 = Date.today + 2.day
    @date4 = Date.today + 3.day
    @date5 = Date.today + 4.day
    @date6 = Date.today + 5.day
    @date7 = Date.today + 6.day

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
      :user => @user,
      # :project => @project1,
      :name => 'ec jungle gym',
      :zipcode => 94530
      )
    @site2 = FactoryGirl.create(
      :site,
      :user => @user,
      # :project => @project2,
      :name => 'ec playground slide',
      :zipcode => 94530
      )
    @sites = [@site1, @site2]
  end

  it "renders the forecast partial" do
    begin
      render
      rendered.should =~ /Site:/
      rendered.should =~ /Zipcode:/
      rendered.should =~ /Date/
      rendered.should =~ /Forecast/
    rescue => e
    end
  end

  it "contains a forecast table" do
    begin
      render
      rendered.should have_selector 'table'
      rendered.should have_selector 'th', :text => "Date"
      rendered.should have_selector 'th', :text => "Forecast"
    rescue => e
    end
  end

  it "renders date with data" do
    begin
      render 'user_mailer/mailout_forecast'
    rescue => e
    end
  end
end
