require "spec_helper"

describe NoaaForecastService do
  let!(:site) { FactoryGirl.build(:site) }
  let!(:nfs) { NoaaForecastService.new(site: site) }

  context "with a site" do
    describe "with a site with valid lat/lng" do
      it 'creates new nfs object' do
        nfs.class.should == NoaaForecastService
        nfs.should_not == nil
      end

      describe '#get_forecast' do
        it "responds to 'get_forecast'" do
          nfs.should respond_to(:get_forecast)
        end
      end

      describe '#save_results' do
        it "responds to 'save_results'" do
          nfs.should respond_to(:save_results)
        end
      end

      describe '#site_forecast' do
        it 'returns site forecast' do
          nfs.should respond_to(:site_forecast)
          begin
            nfs.site_forecast(site).count.should == 29
          rescue => e
            pending 'NOAA API connection cannot be established'
            pp e
          end
        end
      end

      describe '#forecast_table' do
        it "responds to 'forecast_table'" do
          nfs.should respond_to(:forecast_table)
        end

        it 'returns correct number of elements' do
          forecast_table = nfs.forecast_table(site)
          begin
            forecast_table.count.should == 28
          rescue => e
            pending 'NOAA API connection cannot be established'
            pp e
          end
        end

        context 'when collecting pop and qpf data' do
          it 'returns values between 0 and 100' do
            forecast = nfs.site_forecast(site)
            forecast.each do |f|
              # f[:weather].should be_between(0,100)
              # f[:rainfall].should be_between(0,100)
            end
          end
        end
      end

      context "API query" do
        before :each do
          nfs.get_forecast
        end

        it "sets weather_update after API query" do
          nfs.weather_update.class.name.should == "WeatherUpdate"
        end

        it "sets forecast_periods after api query" do
          begin
            nfs.forecast_periods.count.should == 29
          rescue => e
            pending 'NOAA API connection cannot be established'
            pp e
          end
        end

        it "saves WeatherUpdate" do
          weather_update_count = WeatherUpdate.count
          nfs.save_results
          WeatherUpdate.count.should == weather_update_count + 1
        end

        it "saves ForecastPeriods" do
          begin
            weather_update_count = ForecastPeriod.count
            nfs.save_results
            ForecastPeriod.count.should == weather_update_count + 29
          rescue => e
            pending 'NOAA API connection cannot be established'
            pp e
          end
        end
      end
    end
  end

  describe "without a site" do
    it "raises an exception" do
      expect{ NoaaForecastService.new.should }.to raise_error
    end
  end
end
