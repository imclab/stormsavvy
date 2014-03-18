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

  let!(:user) {
    FactoryGirl.build(
      :user,
      firstname: 'yogi',
      lastname: 'bear'
    )
  }
  let!(:site) {
    FactoryGirl.create(
      :site,
      user: user
    )
  }
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
      begin
        lambda do
          forecast = [@data[8], @data[9]]
          fe = ForecastExaminer.new(site, forecast)
          fe.find_rain_chance()
          fe.rain.should == :warning
        end.should change(Report, :count).by(1)
      rescue => e
        pp e
      end
    end

    it "checks for rain imminent" do
      begin
        lambda do
          forecast = [@data[6], @data[7]]
          fe = ForecastExaminer.new(site, forecast)
          fe.find_rain_chance()
          fe.rain.should == :imminent
        end.should change(Report, :count).by(1)
      rescue => e
      end
    end
  end

  describe 'all forecast events' do
    it "checks for rain watch" do
      forecast = [@data[2], @data[3]]
      fe = ForecastExaminer.new(site, forecast)
      fe.find_rain_chance(50, 27)
      fe.rain.should == :watch
    end

    it "checks for clear conditions" do
      forecast = [@data[0], @data[1]]
      fe = ForecastExaminer.new(site, forecast)
      fe.find_rain_chance(50, 27)
      fe.rain.should == :clear
    end
  end
end
