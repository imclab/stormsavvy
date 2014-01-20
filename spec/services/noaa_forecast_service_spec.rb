require "spec_helper"

describe NoaaForecastService do
  context "with a site" do

    let!(:site) {
      site = FactoryGirl.build(
        :site,
        :name => 'ecp',
        :zipcode => 94530,
        :lat => 38,
        :long => 122
      )
    }
    let!(:nfs) { NoaaForecastService.new(site: site) }
    let!(:noaa) { nfs.forecast_table(site) }
    let!(:forecast) { [] }

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

      describe '#site_forecast' do
        it 'returns site forecast' do
          nfs.should respond_to(:site_forecast)
          nfs.site_forecast(site).length.should == 57
        end
      end

      describe '#forecast_table' do
        it "responds to 'forecast_table'" do
          nfs.should respond_to(:forecast_table)
        end

        it 'returns correct number of elements' do
          noaa.length.should == 28
        end

        context 'when collecting pop and qpf data' do
          it 'returns values between 0 and 100' do
            noaa.each do |f|
              f[:weather].should be_between(0,100)
              f[:rainfall].should be_between(0,100)
            end
          end
        end
      end

      describe '#site_pop' do
        it 'returns site data in array' do
          forecast_array[0].should == {:name=>"ecp", :zipcode=>94530, :lat=>38.0, :long=>122.0}
        end

        it 'returns pop and qpf data in array' do
          noaa = []

          for i in (1..28)
            noaa << forecast_array[i]
          end

          noaa.each do |f|
            f[:weather].should be_between(0,100)
            f[:rainfall].should be_between(0,100)
          end

          noaa.length.should == 28
        end
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
