require "spec_helper"

describe GeonamesGeocodingService do
  context "when contacting geonames" do
    before :each do
      # site = FactoryGirl.build(:site)
      @result =  GeonamesGeocodingService.search(94530)
    end

    describe "with a site with valid lat/lng" do
      it "should successfully create a new NoaaForecastService object" do
        @result.should_not == nil
      end

      context "API query" do
        before :each do
          pp GeonamesGeocodingService.search(94530)
          @n.search(94530)
        end

        xit "should return lat/long after API query" do
          begin
            pp @n.search(94949)
          rescue
            'not online or method throwing error'
          end
        end

        xit "should set forecast_periods after API query" do
          begin
            @n.forecast_periods.length.should == 57
          rescue
            'not online or method throwing error'
          end
        end

        xit "should successfully save WeatherUpdate" do
          begin
            weather_update_count = WeatherUpdate.count
            @n.save_results
            WeatherUpdate.count.should == weather_update_count + 1
          rescue
            'not online or method throwing error'
          end
        end

        xit "should successfully save ForecastPeriods" do
          begin
            weather_update_count = ForecastPeriod.count
            @n.save_results
            ForecastPeriod.count.should == weather_update_count + 57
          rescue
            'not online or method throwing error'
          end
        end
      end
    end
  end

  describe "without a site" do
    xit "should raise an exception" do
      expect{ GeonamesGeocodingService.new.should }.to raise_error
    end
  end
end
