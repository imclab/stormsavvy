require 'spec_helper'
require 'weather/forecast_examiner'

describe ForecastExaminer do
  before(:all) do
    @data = []
    CSV.foreach(Rails.root.to_s + '/spec/lib/weather/ss_fc_fixture.csv') do |row|
      @data << row
    end
    @data.delete_if { |r| r == [] }
  end

  let!(:site) { FactoryGirl.create(:site) }
  let!(:fe) { double(ForecastExaminer) }

  before(:each) do
    @fe = double(ForecastExaminer)
  end

  context 'given correct params' do
    it "returns valid class" do
      forecast = [@data[0],@data[1]]
      fe = ForecastExaminer.new(@site, forecast)
      fe.class.should == ForecastExaminer
    end
  end

  describe "report generating events" do
    it "checks for rain warning" do
      lambda do
        forecast = [@data[8], @data[9]]
        fe = ForecastExaminer.new(site, forecast)
        fe.find_rain_chance()
        fe.rain.should == :warning
      end.should change(Report, :count).by(1)
    end

    it "should check for rain imminent" do
      lambda do
        forecast = [@data[6], @data[7]]
        fe = ForecastExaminer.new(site, forecast)
        fe.find_rain_chance()
        fe.rain.should == :imminent
      end.should change(Report, :count).by(1)
    end
  end

  describe 'all forecast events' do
    it "should check for rain watch" do
      forecast = [@data[2], @data[3]]
      fe = ForecastExaminer.new(site, forecast)
      fe.find_rain_chance(50, 27)
      fe.rain.should == :watch
    end

    it "should check for clear" do
      forecast = [@data[0], @data[1]]
      fe = ForecastExaminer.new(site, forecast)
      fe.find_rain_chance(50, 27)
      fe.rain.should == :clear
    end
  end
end
