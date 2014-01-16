require 'spec_helper'

describe "alert_mailer/noaa_forecast" do

  before(:each) do
    @user = FactoryGirl.build(:user)
    @site = @user.sites.create(
      name: 'ecp',
      zipcode: 94530
    )
    sign_in @user
  end

  it "renders the noaa forecast alert email view" do
    render
    rendered.should =~ /Here are the daily forecasts for your sites:/
  end
end
