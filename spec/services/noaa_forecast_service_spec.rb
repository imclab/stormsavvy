require "spec_helper"

describe NoaaForecastService do
  let!(:site) { site = FactoryGirl.build(:site,) }
  let!(:nfs) { NoaaForecastService.new(site: site) }
  # let!(:noaa) { nfs.forecast_table(site) }
  # let!(:forecast) { [] }
  let(:forecast) {
    [
      {:date=>"Saturday, 15 February 2014 00:00 UTC", :weather=>6, :rainfall=>0.0},
      {:date=>"Saturday, 15 February 2014 06:00 UTC", :weather=>6, :rainfall=>0.0},
      {:date=>"Saturday, 15 February 2014 12:00 UTC", :weather=>10, :rainfall=>0.0},
      {:date=>"Saturday, 15 February 2014 18:00 UTC", :weather=>10, :rainfall=>0.0},
      {:date=>"Sunday, 16 February 2014 00:00 UTC", :weather=>20, :rainfall=>0.01},
      {:date=>"Sunday, 16 February 2014 06:00 UTC", :weather=>20, :rainfall=>0.01},
      {:date=>"Sunday, 16 February 2014 12:00 UTC", :weather=>22, :rainfall=>0.01},
      {:date=>"Sunday, 16 February 2014 18:00 UTC", :weather=>22, :rainfall=>0.01},
      {:date=>"Monday, 17 February 2014 00:00 UTC", :weather=>61, :rainfall=>0.34},
      {:date=>"Monday, 17 February 2014 06:00 UTC", :weather=>61, :rainfall=>0.34},
      {:date=>"Monday, 17 February 2014 12:00 UTC", :weather=>65, :rainfall=>0.04},
      {:date=>"Monday, 17 February 2014 18:00 UTC", :weather=>65, :rainfall=>0.04},
      {:date=>"Tuesday, 18 February 2014 00:00 UTC", :weather=>20, :rainfall=>0.01},
      {:date=>"Tuesday, 18 February 2014 06:00 UTC", :weather=>20, :rainfall=>0.01},
      {:date=>"Tuesday, 18 February 2014 12:00 UTC", :weather=>10, :rainfall=>0.0},
      {:date=>"Tuesday, 18 February 2014 18:00 UTC", :weather=>10, :rainfall=>0.0},
      {:date=>"Wednesday, 19 February 2014 00:00 UTC", :weather=>5, :rainfall=>0.0},
      {:date=>"Wednesday, 19 February 2014 06:00 UTC", :weather=>5, :rainfall=>0.0},
      {:date=>"Wednesday, 19 February 2014 12:00 UTC", :weather=>5, :rainfall=>0.0},
      {:date=>"Wednesday, 19 February 2014 18:00 UTC", :weather=>5, :rainfall=>0.0},
      {:date=>"Thursday, 20 February 2014 00:00 UTC", :weather=>7, :rainfall=>0.0},
      {:date=>"Thursday, 20 February 2014 06:00 UTC", :weather=>7, :rainfall=>0.0},
      {:date=>"Thursday, 20 February 2014 12:00 UTC", :weather=>7, :rainfall=>0.0},
      {:date=>"Thursday, 20 February 2014 18:00 UTC", :weather=>7, :rainfall=>0.0},
      {:date=>"Friday, 21 February 2014 00:00 UTC", :weather=>15, :rainfall=>0.01},
      {:date=>"Friday, 21 February 2014 06:00 UTC", :weather=>15, :rainfall=>0.01},
      {:date=>"Friday, 21 February 2014 12:00 UTC", :weather=>15, :rainfall=>0.01},
      {:date=>"Friday, 21 February 2014 18:00 UTC", :weather=>15, :rainfall=>0.01}
    ]
  }

  before :each do
    site.stub(:forecast_table) { return forecast }
    site.stub(:site_forecast) { return forecast }
  end

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
          nfs.site_forecast(site).count.should == 57
        end
      end

      describe '#forecast_table' do
        it "responds to 'forecast_table'" do
          nfs.should respond_to(:forecast_table)
        end

        it 'returns correct number of elements' do
          forecast.count.should == 28
        end

        context 'when collecting pop and qpf data' do
          it 'returns values between 0 and 100' do
            forecast.each do |f|
              f[:weather].should be_between(0,100)
              f[:rainfall].should be_between(0,100)
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
          nfs.forecast_periods.count.should == 57
        end

        it "saves WeatherUpdate" do
          weather_update_count = WeatherUpdate.count
          nfs.save_results
          WeatherUpdate.count.should == weather_update_count + 1
        end

        it "saves ForecastPeriods" do
          weather_update_count = ForecastPeriod.count
          nfs.save_results
          ForecastPeriod.count.should == weather_update_count + 57
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
