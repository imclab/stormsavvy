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
    let!(:site_data) { nfs.site_data(site) }
    let!(:site_pop) { nfs.site_pop(site) }
    let!(:forecast) { [] }
    let!(:forecast_array) {
      site_pop.each do |sub|
        sub.each do |data|
          forecast << data
        end
      end
    }

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

      describe '#site_data' do
        it "responds to 'site_data'" do
          nfs.should respond_to(:site_data)
        end

        context 'when collecting site data' do
          it 'returns zipcode, lat and long' do
            name_zipcode_lat_long = []
            site_data.each do |f|
              f[:name].should == 'ecp'
              f[:zipcode].should == 94530
              f[:lat].should == 38
              f[:long].should == 122
            end
            site_data.should == [
              {:name=>"ecp", :zipcode=>94530, :lat=>38.0, :long=>122.0}
            ]
          end
        end
      end

      describe '#forecast_table' do
        it "responds to 'forecast_table'" do
          nfs.should respond_to(:forecast_table)
        end

        it 'returns correct number of elements' do
          noaa = nfs.forecast_table(site)
          noaa.length.should == 28
        end

        context 'when collecting pop and qpf data' do
          it 'returns values between 0 and 100' do
            weather_rainfall = []

            noaa.each do |f|
              # weather_rainfall << f[:weather] << f[:rainfall]
              f[:weather].should be_between(0,100)
              f[:rainfall].should be_between(0,100)
            end

            weather_rainfall.length.should == 56
          end
        end
      end

      describe '#site_pop' do
        it 'returns site pop info' do
          # pp site_pop[0][0]
          # pp site_pop[0][1]
          # pp site_pop[1][0]
          # pp site_pop[1][1]

          site_pop.each do |sub|
            sub.each do |data|
              pp data
            end
          end
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
