require 'spec_helper'

describe "alert_mailer/noaa_alert" do

  it "renders the noaa alert email view" do
    render
    rendered.should =~ /jghslafkjgalkjsfhl/
  end

end
