require 'spec_helper'
require 'current_user_object'

describe DashboardHelper do

  let(:fullcount) { 29 }
  let(:zipcode) { 94530 }
  let(:lat) { 37.9202057 }
  let(:long) { -122.2937428 }
  let(:nf) { double(NOAAForecast) }
  let(:nf2) { NOAAForecast.new(zipcode, 168, 6) }
  let(:pop) { nf.pop }
  let(:qpf) { nf.qpf }

  describe '#chance_of_rain' do
    it "returns @max_rain" do
      nf2.seven_day_weather(zipcode)

      # where is method called in noaa forecast?
      # @max_rain = nf.noaa_forecast[0][0..4].max
    end
  end

  describe '#precipitation_state' do
    it "returns @rain_state" do
      forecast = []
      if forecast == [[],[]]
        @rain_state = :null
        return
      end
      fe = ForecastExaminer.new(@site, forecast)
      # fe.find_rain_chance()
      # @rain_state = fe.rain
    end
  end

  describe "#get_projects" do
  end

  describe "#get_sites" do
  end

  describe "#get_ie" do
  end

  describe "#get_reports" do
  end

  describe "#pending_reports" do
  end
end
