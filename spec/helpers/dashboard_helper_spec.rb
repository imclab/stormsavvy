require 'spec_helper'
require 'current_user_object'

describe DashboardHelper do

  let(:fullcount) { 29 }
  let(:zipcode) { 94530 }
  let(:lat) { 37.9202057 }
  let(:long) { -122.2937428 }
  # let(:nf) { double(NOAAForecast) }
  let(:nf) { NOAAForecast.new(zipcode, 168, 6) }
  let(:pop) { nf.pop }
  let(:qpf) { nf.qpf }

  describe '#chance_of_rain' do
    it "returns @max_rain" do
      begin
        nf.seven_day_weather(zipcode)
      rescue => e
      end
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
    end
  end

  describe '#get_pop' do
    # spec goes here
  end
end
