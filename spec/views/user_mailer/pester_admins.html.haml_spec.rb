require 'spec_helper'

describe "user_mailer/pester_admins" do

  before(:all) do
    @greeting = "Greetings"
    @forecast1 = [{ :date => Date.today, :weather => "90" },
                  { :date => Date.today + 1.day, :weather => "85"},
                  { :date => Date.today + 2.day, :weather => "80"},
                  { :date => Date.today + 3.day, :weather => "75"},
                  { :date => Date.today + 4.day, :weather => "70"},
                  { :date => Date.today + 5.day, :weather => "65"},
                  { :date => Date.today + 6.day, :weather => "60"}]
    @date1 = Date.today
    @date2 = Date.today + 1.day
    @date3 = Date.today + 2.day
    @date4 = Date.today + 3.day
    @date5 = Date.today + 4.day
    @date6 = Date.today + 5.day
    @date7 = Date.today + 6.day
    # @forecast1 = [{ :date => "today", :weather => "90" }]
  end

  it "greet the admin user" do
    render
    rendered.should =~ /Daily Admin Email/
  end
end