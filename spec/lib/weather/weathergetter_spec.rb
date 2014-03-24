require 'spec_helper'
require 'typhoeus'
require 'json'
require 'weather/weathergetter'

include Typhoeus

describe WeatherGetter do

  let(:site) { FactoryGirl.build(:site) }
  let(:ucb) { FactoryGirl.build(:site, name: 'ucb') }
  let(:ecp) { FactoryGirl.build(:site, name: 'ecp') }
  let(:sites) { [ site, ucb, ecp ] }
  let(:zipcode) { site.zipcode }

  let(:json) { JSON.parse(IO.read('./spec/fixtures/wunderground_10day.json')) }
  let!(:wg) { WeatherGetter.new }
  let(:ww) { WeatherWorker.new }
  let(:forecast) { wg.get_forecast(zipcode) }
  let(:forecastday) { wg.parse_wunderground_10day(json) }
  # let(:apikey) { Stormsavvy::Application.config.wunderground_apikey }
  # let(:apikey) { ENV["WUNDERGROUND_APIKEY"] }
  # let(:url) { "http://api.wunderground.com/api/#{apikey}/forecast10day/q/#{zipcode}.json" }

  describe '#make_request' do
    it 'makes request' do
      wg.class.should == WeatherGetter
      wg.should respond_to(:make_request)
    end
  end

  describe '#make_request_with_cache' do
    it 'makes request with cache' do
      wg.should respond_to(:make_request_with_cache)
    end
  end

  describe '#display_forecast' do
    it 'displays forecast for given zipcode' do
      wg.should respond_to(:display_forecast)
      forecastday = wg.display_forecast(zipcode)
      forecastday.each do |f|
        f['pop'].should be_between(0,100)
        f['qpf_allday'].count.should == 2
        f['qpf_allday']['in'].should be_between(0,100)
        f['date']['day'].should be_between(0,31)
      end
    end
  end

  describe '#get_forecast' do
    it 'reads json and does not query' do
      json.should have(2).items
    end

    it "gets the weather for given zipcode" do
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
      wg.should_not respond_to(:parse_wunderground_10day)
      expect{ wg.parse_wunderground_10day(forecast).should }.to raise_error

      forecastday = wg.parse_wunderground_10day(json)
      forecastday.should have(10).items
    end
  end

  describe '#forecast_table' do
    it 'returns forecast for given site' do
      wg.should_not respond_to(:forecast_table)
      expect{ wg.forecast_table(zipcode).should }.to raise_error

      forecastday = wg.forecast_table(site)
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
