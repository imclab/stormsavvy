require 'spec_helper'

describe "alert_mailer/pop_alert.html.haml" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:site) {
    FactoryGirl.create(
      :site,
      user: user
    )
  }
  # let!(:forecast) { site.forecast }
  let(:forecast) { IO.read("./spec/lib/weather/noaa_response.xml") }
  let!(:fe) { ForecastExaminer.new(site, forecast) }

  before {
    @forecast_table = []
    nfs = NoaaForecastService.new(site: site)
    noaa_table = nfs.forecast_table(site)
    @forecast_table << noaa_table
  }

  before(:each) do
    sign_in user
    @user = user
    @site = site
    render
  end

  it "renders mailer" do
    rendered.should match(/NOAA POP Alert/)
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
      pp e
    end
  end
end
