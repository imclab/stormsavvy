require 'spec_helper'

describe "alert_mailer/noaa_forecast" do

  it "renders the noaa forecast alert email view" do
    render
    rendered.should =~ /Future mailer for NOAA forecasts/
  end

end
