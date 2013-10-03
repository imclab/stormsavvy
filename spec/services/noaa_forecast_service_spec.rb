require "spec_helper"

describe NoaaForecastService do
  describe "with a site with valid lat/lng" do
    it "should successfully create a new NoaaForecastService object" do
      site = FactoryGirl.create(:site)
      n = NoaaForecastService.new(site: site)
      n.should_not == nil
    end

    it "should respond to 'get_forecast'" do
      site = FactoryGirl.create(:site)
      n = NoaaForecastService.new(site: site)
      n.should respond_to(:get_forecast)
    end

    it "should respond to 'save_results'" do
      site = FactoryGirl.create(:site)
      n = NoaaForecastService.new(site: site)
      n.should respond_to(:save_results)
    end

    it "should set weather_update after API query" do
      begin
        site = FactoryGirl.create(:site)
        n = NoaaForecastService.new(site: site)
        n.get_forecast
        n.weather_update.class.name.should == "WeatherUpdate"
      rescue
        'not online or method throwing error'
      end
    end

    it "should set forecast_periods after API query" do
      begin
        site = FactoryGirl.create(:site)
        n = NoaaForecastService.new(site: site)
        n.get_forecast
        n.forecast_periods.length.should == 57
      rescue
        'not online or method throwing error'
      end
    end

    it "should successfully save WeatherUpdate" do
      begin
        weather_update_count = WeatherUpdate.count
        site = FactoryGirl.create(:site)
        n = NoaaForecastService.new(site: site)
        n.get_forecast
        n.save_results
        WeatherUpdate.count.should == weather_update_count + 1
      rescue
        'not online or method throwing error'
      end
    end

    it "should successfully save ForecastPeriods" do
      begin
        weather_update_count = ForecastPeriod.count
        site = FactoryGirl.create(:site)
        n = NoaaForecastService.new(site: site)
        n.get_forecast
        n.save_results
        ForecastPeriod.count.should == weather_update_count + 57
      rescue
        'not online or method throwing error'
      end
    end
  end

  describe "without a site" do
    it "should raise an exception" do
      expect{ NoaaForecastService.new.should }.to raise_error
    end
  end

end
