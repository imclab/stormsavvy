require 'spec_helper'

describe "alert_mailer/noaa_forecast" do

  let!(:user) { FactoryGirl.build(:user) }
  let!(:site) { user.sites.build(
    name: 'ecp',
    zipcode: 94530
    )
  }

  it "renders the noaa forecast alert email view" do
    sign_in user
    @user = user

    site.save
    @site = site

    nfs = NoaaForecastService.new(site: site)
    @pop = nfs.forecast_table(site)

    render
    rendered.should =~ /Here are the daily forecasts for your sites:/
    rendered.should =~ /Here are the weekly forecasts for your sites:/

    rendered.should =~ /Date/
    rendered.should =~ /Chance of Rain/
    rendered.should =~ /Forecast Rain/

    rendered.should =~ /UTC/
    rendered.should =~ /%/
    rendered.should =~ /"/
  end
end
