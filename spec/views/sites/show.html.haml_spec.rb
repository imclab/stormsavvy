require 'spec_helper'
require 'json'
require 'weather/forecast_examiner'
require 'weather/weathergetter'
require 'weather/noaa_forecast'

describe "sites/show" do
  before(:all) do
    @data = []
    CSV.foreach(Rails.root.to_s + '/spec/lib/weather/ss_fc_fixture.csv') do |row|
      @data << row
    end
    @data.delete_if { |r| r == [] }
  end

  let(:wg) { WeatherGetter.new }
  let(:nf) { NOAAForecast.new(zipcode,duration,interval) }

  before {
    @user = FactoryGirl.create(:user)
    @site = assign(:site,
      stub_model(
        Site,
        name: "Name",
        zipcode: "Zipcode",
        user: @user
      )
    )
    # wg.stub(:wg_table) { return forecastday }
    # @site.stub(:forecast_table) { return forecast }
    # nf.stub(:ping_noaa).with([lat, long],duration,interval).and_return(response)

    render
  }

  let(:lat) { @site.lat }
  let(:long) { @site.long }
  let(:zipcode) { @site.zipcode }
  let(:latlong) { [ lat, long ] }
  let(:duration) { 168 }
  let(:interval) { 6 }
  let(:forecast_array) {
    [
      [90,78,16,8,7,0,14,12,14,14,14,24,50,59,65,49,11,11,5,5,4,4,5,5,6,6,8,8,11],
      [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    ]
  }
  let(:forecast) {
    [
      {:date=>"Saturday, 15 February 2014 00:00 UTC", :weather=>6, :rainfall=>0.0},
      {:date=>"Saturday, 15 February 2014 06:00 UTC", :weather=>6, :rainfall=>0.0},
      {:date=>"Saturday, 15 February 2014 12:00 UTC", :weather=>10, :rainfall=>0.0},
      {:date=>"Saturday, 15 February 2014 18:00 UTC", :weather=>10, :rainfall=>0.0},
      {:date=>"Sunday, 16 February 2014 00:00 UTC", :weather=>20, :rainfall=>0.01},
      {:date=>"Sunday, 16 February 2014 06:00 UTC", :weather=>20, :rainfall=>0.01},
      {:date=>"Sunday, 16 February 2014 12:00 UTC", :weather=>22, :rainfall=>0.01},
      {:date=>"Sunday, 16 February 2014 18:00 UTC", :weather=>22, :rainfall=>0.01},
      {:date=>"Monday, 17 February 2014 00:00 UTC", :weather=>61, :rainfall=>0.34},
      {:date=>"Monday, 17 February 2014 06:00 UTC", :weather=>61, :rainfall=>0.34},
      {:date=>"Monday, 17 February 2014 12:00 UTC", :weather=>65, :rainfall=>0.04},
      {:date=>"Monday, 17 February 2014 18:00 UTC", :weather=>65, :rainfall=>0.04},
      {:date=>"Tuesday, 18 February 2014 00:00 UTC", :weather=>20, :rainfall=>0.01},
      {:date=>"Tuesday, 18 February 2014 06:00 UTC", :weather=>20, :rainfall=>0.01},
      {:date=>"Tuesday, 18 February 2014 12:00 UTC", :weather=>10, :rainfall=>0.0},
      {:date=>"Tuesday, 18 February 2014 18:00 UTC", :weather=>10, :rainfall=>0.0},
      {:date=>"Wednesday, 19 February 2014 00:00 UTC", :weather=>5, :rainfall=>0.0},
      {:date=>"Wednesday, 19 February 2014 06:00 UTC", :weather=>5, :rainfall=>0.0},
      {:date=>"Wednesday, 19 February 2014 12:00 UTC", :weather=>5, :rainfall=>0.0},
      {:date=>"Wednesday, 19 February 2014 18:00 UTC", :weather=>5, :rainfall=>0.0},
      {:date=>"Thursday, 20 February 2014 00:00 UTC", :weather=>7, :rainfall=>0.0},
      {:date=>"Thursday, 20 February 2014 06:00 UTC", :weather=>7, :rainfall=>0.0},
      {:date=>"Thursday, 20 February 2014 12:00 UTC", :weather=>7, :rainfall=>0.0},
      {:date=>"Thursday, 20 February 2014 18:00 UTC", :weather=>7, :rainfall=>0.0},
      {:date=>"Friday, 21 February 2014 00:00 UTC", :weather=>15, :rainfall=>0.01},
      {:date=>"Friday, 21 February 2014 06:00 UTC", :weather=>15, :rainfall=>0.01},
      {:date=>"Friday, 21 February 2014 12:00 UTC", :weather=>15, :rainfall=>0.01},
      {:date=>"Friday, 21 February 2014 18:00 UTC", :weather=>15, :rainfall=>0.01}
    ]
  }
  let(:json) { JSON.parse(IO.read('./spec/fixtures/wunderground_10day.json')) }
  let(:forecastday) { wg.parse_wunderground_10day(json) }
  let(:response) { IO.read("./spec/lib/weather/noaa_response.xml") }

  it 'renders site map' do
    rendered.should match(/Site Map/)
  end

  it "renders site info" do
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
  end

  it 'renders weekly report info' do
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
      pp e
    end
  end

  it "has edit, back and delete links" do
    rendered.should match(/Edit/)
    rendered.should match(/Back/)
    rendered.should match(/Delete/)
    rendered.should have_link('Edit')
    rendered.should have_link('Back')
    rendered.should have_button('Delete This Site')
  end
end
