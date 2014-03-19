require 'spec_helper'

describe WeatherUpdate do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:site) { FactoryGirl.create(:site, user: user) }
  let!(:weather_update) { FactoryGirl.create(:weather_update, site: site) }
  let!(:forecast_period) { FactoryGirl.create(:forecast_period, weather_update: weather_update) }

  describe 'site associations' do
    it 'responds to weather_updates' do
      site.should respond_to(:weather_updates)
    end

    it 'destroys associated sites' do
      site.destroy
      WeatherUpdate.find_by_id(weather_update.id).should be_nil
    end
  end

  describe 'forecast_period associations' do
    it 'responds to weather_updates' do
      weather_update.should respond_to(:forecast_periods)
    end

    it 'destroys associated sites' do
      weather_update.destroy
      ForecastPeriod.find_by_id(weather_update.id).should be_nil
    end
  end

  describe "attributes" do
    it 'has correct attributes' do
      weather_update.forecast_creation_time.should == "2013-09-02 16:45:33"
      weather_update.lat.should == 1.5
      weather_update.lng.should == 1.5
      weather_update.elevation.should == 1
      weather_update.duration.should == 1
      weather_update.interval.should == 1
    end
  end

  describe '#build_from_xml' do
    it 'responds to #build_from_xml' do
      weather_update.should respond_to(:build_from_xml)
    end
  end
end
