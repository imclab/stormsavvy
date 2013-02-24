require 'spec_helper'

describe "alert_mailer/noaa_forecast" do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @project = @user.projects.build(
      :name => "foo", 
      :description => "bar",
      :startdate => Date.today,
      :finishdate => Date.today + 30.days
    )
    @project.save
    sign_in @user
  end

  it "renders the noaa forecast alert email view" do
    render
    rendered.should =~ /Here is your NOAA forecast:/
  end
end
