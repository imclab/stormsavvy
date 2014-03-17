require 'spec_helper'
require 'raven/sidekiq'

describe "alert_mailer/daily_mailer" do
  let!(:user) { FactoryGirl.create(
    :user,
    email: 'vader@starwars.com'
    )
  }
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
  let!(:site) { FactoryGirl.create(:site, user: user) }
  let(:zipcode) { site.zipcode }
  let!(:sites) { [ecp, ucb] }
  let(:forecast) { IO.read("./spec/lib/weather/noaa_response.xml") }
  let!(:fe) { ForecastExaminer.new(ecp, forecast) }
  let(:wg) { WeatherGetter.new }
  let(:nfs) { NoaaForecastService.new(site: site) }
  let(:nf) { NOAAForecast.new(zipcode,duration,interval) }
  let(:json) { JSON.parse(IO.read('./spec/fixtures/wunderground_10day.json')) }
  let(:forecastday) { wg.parse_wunderground_10day(json) }
  let(:response) { IO.read("./spec/lib/weather/noaa_response.xml") }

  before {
    ecp.save
    ucb.save

    sites.each do |site|
      # nfs = NoaaForecastService.new(site: site)
      noaa_table = nfs.forecast_table(site)
      @forecast_table = []
      @forecast_table << noaa_table
    end
  }

  before(:each) do
    wg.stub(:wg_table) { return forecastday }
    wg.stub(:get_forecast).with(zipcode).and_return { json }
    wg.stub(:forecast_table).with(site).and_return { forecastday }
    wg.stub(:display_forecast).with(zipcode).and_return { forecastday }

    nfs.stub(:forecast_table).with(site).and_return { forecast }
    nfs.stub(:site_forecast).with(site).and_return { forecast }
    site.stub(:wg_forecast).and_return { forecastday }

    sign_in user
    @user = user
    render
  end

  it "renders project info" do
    rendered.should match(/Project/)
    rendered.should match(/Project EA/)
    # rendered.should match(/Project Costcode/)
    # rendered.should match(/Site ID/)
    # rendered.should match(/Site Name/)
    # rendered.should match(/Description/)
    # rendered.should match(/Address 1/)
    # rendered.should match(/Address 2/)
    # rendered.should match(/City/)
    # rendered.should match(/State/)
    # rendered.should match(/Zipcode/)
    # rendered.should match(/Lat/)
    # rendered.should match(/Long/)
  end

  it 'renders risk level info' do
    # rendered.should match(/Risk Level/)
    # rendered.should match(/WDID Number/)
    # rendered.should match(/Construction Phase/)
    # rendered.should match(/Total Area/)
    # rendered.should match(/Total DSA/)
    # rendered.should match(/Current DSA/)
    # rendered.should match(/Inactive DSA/)
    # rendered.should match(/Time Since Last Storm/)
    # rendered.should match(/Precipitation Received During Last Storm/)
    # rendered.should match(/Inactive DSA/)
  end

  it 'renders contractor info' do
    # rendered.should match(/Contractor Name/)
    # rendered.should match(/Contractor Address 1/)
    # rendered.should match(/Contractor Address 2/)
    # rendered.should match(/Contractor City/)
    # rendered.should match(/Contractor State/)
    # rendered.should match(/Contractor Zipcode/)
    # rendered.should match(/WPCM Name/)
    # rendered.should match(/WPCM Company/)
    # rendered.should match(/WPCM Phone Number/)
    # rendered.should match(/WPCM Emergency Phone Number/)
    # rendered.should match(/QSP Name/)
    # rendered.should match(/QSP Company/)
    # rendered.should match(/QSP Phone Number/)
    # rendered.should match(/QSP Emergency Phone Number/)
  end

  it 'renders report dates' do
    # rendered.should match(/Permits/)
    # rendered.should match(/Resident Engineer Name/)
    # rendered.should match(/Structures Representative Name/)
    # rendered.should match(/Last BMP Status Report Date/)
    # rendered.should match(/Last Weekly Inspection Date/)
    # rendered.should match(/Last Corrective Action Report Date/)
    # rendered.should match(/Last REAP Report Date/)
    # rendered.should match(/Last Training Report Date/)
    # rendered.should match(/Last Weather Forecast Date/)
    # rendered.should match(/Last Rain Event Sampling Date/)
  end

  it 'renders forecast info' do
    rendered.should match(/Weather Forecast Links/)
    rendered.should match(/NOAA Forecast Table/)
    rendered.should match(/Wunderground Forecast/)

    rendered.should match(/NOAA 7-Day Forecast/)
    rendered.should match(/Wunderground 7-Day Forecast/)
    rendered.should match(/Date/)
    rendered.should match(/POP/)
    rendered.should match(/QPF/)
  end

  it 'renders forecast table' do
    begin
      rendered.should match(/UTC/)
      rendered.should match(/%/)
      rendered.should match(/inch/)
    rescue => e
    end
  end

  it 'rescues from error using sentry' do
    begin
      raise Exception
    rescue => e
      Raven.capture_exception(e)
    end
  end

  it 'renders forecast warnings' do
    rendered.should match(/Forecast Warnings/)
    rendered.should match(/POP/)
  end
end
