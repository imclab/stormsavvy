require 'spec_helper'

describe "user_mailer/_pester_forecast" do

  before(:all) do
    @forecast1 = [
      { :date => Date.today + 0.day, :weather => "90", :rain => "0" },
      { :date => Date.today + 1.day, :weather => "85", :rain => "1" },
      { :date => Date.today + 2.day, :weather => "80", :rain => "2" },
      { :date => Date.today + 3.day, :weather => "75", :rain => "3" },
      { :date => Date.today + 4.day, :weather => "70", :rain => "4" },
      { :date => Date.today + 5.day, :weather => "65", :rain => "5" },
      { :date => Date.today + 6.day, :weather => "60", :rain => "6" }
    ]
    @date1 = Date.today + 0.day
    @date2 = Date.today + 1.day
    @date3 = Date.today + 2.day
    @date4 = Date.today + 3.day
    @date5 = Date.today + 4.day
    @date6 = Date.today + 5.day
    @date7 = Date.today + 6.day
  end

  it "renders the forecast partial" do
    render
    rendered.should have_content "Date"
    rendered.should have_content "Forecast"
    rendered.should have_content "Rainfall"
  end

  it "contains a forecast table" do
    render
    rendered.should have_selector 'table'
    rendered.should have_selector 'th', :text => "Date"
    rendered.should have_selector 'th', :text => "Forecast"
    rendered.should have_selector 'th', :text => "Rainfall"
  end

  it "renders date with data" do
    render
    rendered.should have_content @date1
    rendered.should have_content @date2
    rendered.should have_content @date3
    rendered.should have_content @date4
    rendered.should have_content @date5
    rendered.should have_content @date6
    rendered.should have_content @date7

    rendered.should have_content "90"
    rendered.should have_content "85"
    rendered.should have_content "80"
    rendered.should have_content "75"
    rendered.should have_content "70"
    rendered.should have_content "65"
    rendered.should have_content "60"
  end
end