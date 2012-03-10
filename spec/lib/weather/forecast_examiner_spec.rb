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

  before(:each) do
    @fe = ForecastExaminer.new([@data[0],@data[1]])
  end

  it "should be a valid class" do
    @fe.class.should == ForecastExaminer
  end

  it "should check for rain imminent" do
    forecast = [@data[6], @data[7]]
    @fe = ForecastExaminer.new(forecast)
    @fe.find_rain_chance()
    @fe.rain.should == :imminent
  end

  it "should check for rain watch" do
    forecast = [@data[2], @data[3]]
    @fe = ForecastExaminer.new(forecast)
    @fe.find_rain_chance(50, 6)
    @fe.rain.should == :watch
  end

  it "should check for rain warning" do
    forecast = [@data[8], @data[9]]
    @fe = ForecastExaminer.new(forecast)
    @fe.find_rain_chance(50, 6)
    @fe.rain.should == :warning
  end

  it "should check for clear" do
    forecast = [@data[0], @data[1]]
    @fe = ForecastExaminer.new(forecast)
    @fe.find_rain_chance(50, 6)
    @fe.rain.should == :clear
  end

end
