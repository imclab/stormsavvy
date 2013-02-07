require 'spec_helper'

describe "alert_mailer/northbay_forecast.html.haml" do

  it "renders POP alert" do
    # @user = FactoryGirl.build(:user)
    render
    rendered.should =~ /NOAA POP Alert/
  end
end
