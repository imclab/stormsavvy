require 'spec_helper'

describe DashboardHelper do

  before(:each) do
    @fullcount = 29
    @zipcode = 94530
    @lat = 37.9202057
    @long = -122.2937428
    lat_long = [@lat, @long]
    @nf = double(NOAAForecast)
    @nf2 = NOAAForecast.new(@zipcode,168,6)
    # @nf2.seven_day_weather(@zipcode)

    pop= [0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0]
    qpf = [99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99]

    @pop = @nf2.pop
    @qpf = @nf2.qpf

    @user = FactoryGirl.create(:user)
    @project = FactoryGirl.create(
      :project,
      :user => @user,
      :created_at => 1.day.ago
    )
    @projects = [@project]

    @site = FactoryGirl.create(
      :site,
      :project => @project,
      :name => 'ec jungle gym',
      :zipcode => 94530
    )
    @sites = [@site]

    @ie = FactoryGirl.create(
      :inspection_event,
      :site => @site
    )

    @se = FactoryGirl.create(
      :sampling_event,
      :site => @site
    )
  end

  describe '#chance_of_rain' do
    it "returns @max_rain" do
      zipcode = 94530
      @nf2.seven_day_weather(zipcode)

      # where is method called in noaa forecast?
      # @max_rain = nf.noaa_forecast[0][0..4].max
    end
  end

  describe '#precipitation_state' do
    it "returns @rain_state" do
=begin
      if forecast == [[],[]]
        @rain_state = :null
        return
      end
      fe = ForecastExaminer.new(forecast)
      fe.find_rain_chance()
      @rain_state = fe.rain
=end
    end
  end

  describe 'dashboard variables' do
    it 'returns instance variables' do
      # @projects.should == @user.project.all
      # @sites.should == @user.site.all

      @weather_events.should == WeatherEvent.all
      @inspection_events.should == InspectionEvent.all

      @completed_reports.should == Report.completed
      @needs_attention_reports.should == Report.needs_attention
    end
  end
end
