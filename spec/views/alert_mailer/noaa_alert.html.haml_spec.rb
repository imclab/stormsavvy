require 'spec_helper'

describe "alert_mailer/noaa_alert" do

  it "renders the noaa alert email view" do
    render
    rendered.should =~ /NOAA POP Alert/
    rendered.should =~ /Please be advised that there is a forecast rain event in your area./
  end
end
