require 'spec_helper'
require 'weather/weathergetter'
require 'typhoeus'
require 'json'

include Typhoeus

describe WeatherGetter do

  let(:json) { JSON.parse(IO.read('./spec/fixtures/wunderground_10day.json')) }
  let(:wg) { WeatherGetter.new }
  let(:ww) { WeatherWorker.new }
  # let(:forecast) { wg.get_forecast(zipcode) }
  let(:forecastday) { wg.parse_wunderground_10day(json) }
  let(:site) { FactoryGirl.build(:site) }
  let(:zipcode) { site.zipcode }

  before :each do
    wg.stub(:get_forecast).with(zipcode).and_return { json }
    @forecast = wg.get_forecast(zipcode)
    wg.stub(:forecast_table).with(site).and_return { forecastday }
  end

  describe '#get_forecast' do
    it 'reads json and does not query' do
      json.should have(2).items
    end

    it "gets the weather for 94530" do
      wg.should respond_to(:get_forecast)
      forecast = wg.get_forecast(zipcode)
      forecast.should include('response')
      forecast.should include('forecast')
      forecast.should have(2).items
      forecast.count.should == 2
    end
  end

  describe '#parse_wunderground_10day' do
    it "extracts wunderground's 10 day txt_forecast" do
      wg.should respond_to(:parse_wunderground_10day)
      forecastday = wg.parse_wunderground_10day(json)
      forecastday.should have(10).items
    end
  end

  describe '#display_forecast' do
    it 'fetches forecast using background worker' do
      ww.class.should == WeatherWorker
      @forecast.should have(2).items
    end
  end

  describe '#forecast_table' do
    it 'returns forecast for given site' do
      wg.should respond_to(:forecast_table)
      # forecastday = wg.forecast_table(site)
      forecastday.each do |f|
        f['pop'].should be_between(0,100)
        f['qpf_allday'].count.should == 2
        f['qpf_allday']['in'].should be_between(0,100)
        # f['date']['weekday'].count.should == 1
        f['date']['day'].should be_between(0,31)
        # f['date']['monthname'].count.should == 1
        # f['date']['year'].count.should == 1
        # f['date']['hour'].should == 22
        # f['date']['min'].should == 00
        # f['date']['tz_short'].should == 'PDT'
      end
    end
  end
end
