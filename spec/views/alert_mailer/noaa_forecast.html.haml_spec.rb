require 'spec_helper'

describe "alert_mailer/noaa_forecast" do

  let!(:user) { FactoryGirl.build(:user) }
  let!(:ecp) { user.sites.build(
    name: 'ecp',
    zipcode: 94530
    )
  }
  let!(:ucb) { user.sites.build(
    name: 'ucb',
    zipcode: 94709
    )
  }
  let!(:sites) { [] << ecp << ucb }

  it "renders the noaa forecast alert email view" do
    sign_in user
    @user = user

    ecp.save
    ucb.save
    @site_pop = []
    @forecast_table = []

    sites.each do |site|
      nfs = NoaaForecastService.new(site: site)
      forecast_table = nfs.forecast_table(site)
      @forecast_table << forecast_table

      # site_pop = nfs.site_pop(site)
      # @site_pop << site_pop
    end

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
