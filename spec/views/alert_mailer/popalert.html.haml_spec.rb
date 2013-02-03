require 'spec_helper'

describe "alert_mailer/northbay_forecast.html.haml" do

  it "does some thing or another with the POP" do
    @user = FactoryGirl.build(:user)
    render
    rendered.should =~ /Greetings/
  end

end
