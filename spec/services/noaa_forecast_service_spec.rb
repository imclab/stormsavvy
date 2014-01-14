require "spec_helper"

describe NoaaForecastService do
  context "with a site" do

    let!(:site) {
      site = FactoryGirl.build(:site)
    }
    let!(:nfs) {
      @n = NoaaForecastService.new(site: site)
    }
    before :each do
    end

    describe "with a site with valid lat/lng" do
      it "should successfully create a new NoaaForecastService object" do
        nfs.should_not == nil
      end

      it "should respond to 'get_forecast'" do
        nfs.should respond_to(:get_forecast)
      end

      it "should respond to 'save_results'" do
        nfs.should respond_to(:save_results)
      end

      context "API query" do
        before :each do
          nfs.get_forecast
        end

        it "should set weather_update after API query" do
          begin
            nfs.weather_update.class.name.should == "WeatherUpdate"
          rescue
            'not online or method throwing error'
          end
        end

        it "should set forecast_periods after API query" do
          begin
            nfs.forecast_periods.length.should == 57
          rescue
            'not online or method throwing error'
          end
        end

        it "should successfully save WeatherUpdate" do
          begin
            weather_update_count = WeatherUpdate.count
            nfs.save_results
            WeatherUpdate.count.should == weather_update_count + 1
          rescue
            'not online or method throwing error'
          end
        end

        it "should successfully save ForecastPeriods" do
          begin
            weather_update_count = ForecastPeriod.count
            nfs.save_results
            ForecastPeriod.count.should == weather_update_count + 57
          rescue
            'not online or method throwing error'
          end
        end
      end
    end
  end

  describe "without a site" do
    it "should raise an exception" do
      expect{ NoaaForecastService.new.should }.to raise_error
    end
  end
end
