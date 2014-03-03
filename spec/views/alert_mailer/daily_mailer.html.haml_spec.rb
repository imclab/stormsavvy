require 'spec_helper'

describe "alert_mailer/daily_mailer" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:ecp) { user.sites.create(
    name: 'ecp',
    zipcode: 94530
    )
  }
  let!(:ucb) { user.sites.create(
    name: 'ucb',
    zipcode: 94709
    )
  }
  let!(:sites) { [ecp, ucb] }
  let!(:forecast) { ecp.forecast }
  let!(:fe) { ForecastExaminer.new(ecp, forecast) }

  before {
    ecp.save
    ucb.save
    @forecast_table = []

    sites.each do |site|
      nfs = NoaaForecastService.new(site: site)
      noaa_table = nfs.forecast_table(site)
      @forecast_table << noaa_table
    end
  }

  before(:each) do
    sign_in user
    @user = user
    render
  end

  it "renders project info" do
    rendered.should match(/Project/)
    rendered.should match(/Project EA/)
    rendered.should match(/Project Costcode/)
    rendered.should match(/Site ID/)
    rendered.should match(/Site Name/)
    rendered.should match(/Description/)
    rendered.should match(/Address 1/)
    rendered.should match(/Address 2/)
    rendered.should match(/City/)
    rendered.should match(/State/)
    rendered.should match(/Zipcode/)
    rendered.should match(/Lat/)
    rendered.should match(/Long/)
  end

  it 'renders risk level info' do
    rendered.should match(/Risk Level/)
    rendered.should match(/WDID Number/)
    rendered.should match(/Construction Phase/)
    rendered.should match(/Total Area/)
    rendered.should match(/Total DSA/)
    rendered.should match(/Current DSA/)
    rendered.should match(/Inactive DSA/)
    rendered.should match(/Time Since Last Storm/)
    rendered.should match(/Precipitation Received During Last Storm/)
    rendered.should match(/Inactive DSA/)
  end

  it 'renders contractor info' do
    rendered.should match(/Contractor Name/)
    rendered.should match(/Contractor Address 1/)
    rendered.should match(/Contractor Address 2/)
    rendered.should match(/Contractor City/)
    rendered.should match(/Contractor State/)
    rendered.should match(/Contractor Zipcode/)
    rendered.should match(/WPCM Name/)
    rendered.should match(/WPCM Company/)
    rendered.should match(/WPCM Phone Number/)
    rendered.should match(/WPCM Emergency Phone Number/)
    rendered.should match(/QSP Name/)
    rendered.should match(/QSP Company/)
    rendered.should match(/QSP Phone Number/)
    rendered.should match(/QSP Emergency Phone Number/)

    rendered.should match(/Permits/)
    rendered.should match(/Resident Engineer Name/)
    rendered.should match(/Structures Representative Name/)
    rendered.should match(/Last BMP Status Report Date/)
    rendered.should match(/Last Weekly Inspection Date/)
    rendered.should match(/Last Corrective Action Report Date/)
    rendered.should match(/Last REAP Report Date/)
    rendered.should match(/Last Training Report Date/)
    rendered.should match(/Last Weather Forecast Date/)
    rendered.should match(/Last Rain Event Sampling Date/)

    rendered.should match(/Weather Forecast Links/)
    rendered.should match(/NOAA Forecast Table/)
    rendered.should match(/Wunderground Forecast/)

    rendered.should match(/NOAA 7-Day Forecast/)
    rendered.should match(/Wunderground 7-Day Forecast/)
    rendered.should match(/Date/)
    rendered.should match(/POP/)
    rendered.should match(/QPF/)

    rendered.should match(/UTC/)
    rendered.should match(/%/)
    rendered.should match(/inch/)

    # rendered.should match(/Forecast Warnings/)
    # rendered.should match(/Precipitation Warning/)
  end
end
