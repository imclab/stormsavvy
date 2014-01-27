require 'spec_helper'
require 'weather/forecast_examiner'

describe Site do

  before(:all) do
    @data = []
    CSV.foreach(Rails.root.to_s + '/spec/lib/weather/ss_fc_fixture.csv') do |row|
      @data << row
    end
    @data.delete_if { |r| r == [] }
  end

  let!(:lat) { 37.81164190000001 }
  let!(:long) { -122.255463 }
  let!(:zipcode) { 94610 }
  # let!(:zipcode2) { '' }
  let!(:latlong) { [ lat, long ] }
  let!(:address) { '111 Adams Street Suite 181 Oakland CA 94610' }
  let!(:nf) { NOAAForecast.new(zipcode,168,6) }

  let!(:site) { FactoryGirl.create(
    :site
    # name: 'Oakland Adams Point'
    )
  }
  let!(:report) { FactoryGirl.create(
    :report,
    :site => site
    )
  }
  let!(:reports) { [ report ] }

  let!(:inspection_event) { FactoryGirl.create(
      :inspection_event,
      :site => site
      )
  }
  let!(:inspection_events) { [inspection_event] }

  let!(:sampling_event) { FactoryGirl.create(
      :sampling_event,
      :site => site
      )
  }
  let!(:sampling_events) { [sampling_event] }

  describe "validations" do
    it "should have a name" do
      site.name = ''
      site.should_not be_valid
    end
  end

  describe 'report associations' do
    it 'responds to reports' do
      site.should respond_to(:reports)
    end

    it 'has reports in correct order' do
      site.reports.should == reports
    end

    it 'destroys associated sites' do
      site.destroy
      reports.each do |report|
        Report.find_by_id(report.id).should be_nil
      end
    end
  end

  describe 'inspection_event associations' do
    it 'responds to inspection_events' do
      site.should respond_to(:inspection_events)
    end

    it 'has inspection events in correct order' do
      site.inspection_events.should == inspection_events
    end

    it 'destroys associated inspection events' do
      site.destroy
      inspection_events.each do |inspection_event|
        InspectionEvent.find_by_id(inspection_event.id).should be_nil
      end
    end

    xit 'returns inspection events by type' do
      ie = site.inspection_events.build(TYPE: 'CEM2030')
      ie.save
    end
  end

  describe 'sampling_event associations' do
    it 'responds to sampling_events' do
      site.should respond_to(:sampling_events)
    end

    it 'has sampling events in correct order' do
      site.sampling_events.should == sampling_events
    end

    it 'destroys associated sampling events' do
      site.destroy
      sampling_events.each do |sampling_event|
        SamplingEvent.find_by_id(sampling_event.id).should be_nil
      end
    end
  end

  describe "attributes" do
    it 'has correct attributes' do
      # site.name.should == "Oakland Adams Point"
      site.description.should == "North of Lake Merritt"
      site.address_1.should == '111 Adams Street'
      site.address_2.should == 'Suite 181'
      site.costcode.should == "450AZC"
      site.size.should == "20 acres"
      site.exposed_area.should == "10 acres"
      site.city.should == 'Oakland'
      site.zipcode.should == 94610

      site.should respond_to(:user)
    end
  end

  describe 'lat/long stub values' do 
    it "returns correct stub for oakland latlong" do
      site.lat.round.should == 38
      site.long.round.should == 123
    end
  end

  describe '#address' do
    it 'returns site address' do
      site.address.should == address
    end
  end

  describe '#precipitation_state' do
    it 'sets rain state to imminent' do
      forecast = [@data[6], @data[7]]
      site.precipitation_state(forecast).should == :imminent
    end

    it 'sets rain state to warning' do
      forecast = [@data[8], @data[9]]
      site.precipitation_state(forecast).should == :warning
    end

    it 'sets rain state to watch' do
      forecast = [@data[2], @data[3]]
      site.precipitation_state(forecast).should == :watch
    end

    it 'sets rain state to clear' do
      forecast = [@data[0], @data[1]]
      site.precipitation_state(forecast).should == :clear
    end
  end

  describe '#chance_of_rain' do
    it 'returns chance of rain' do
      site.should respond_to(:chance_of_rain)
      max_rain = site.chance_of_rain
      pp max_rain.pop
      max_rain.pop.should be_between(0,100)
    end
  end

  describe '#forecast_table' do
    it 'returns forecast table' do
      site.should respond_to(:forecast_table)

      forecast = site.forecast_table
      forecast.each do |f|
        if f[:weather] == -999
          f[:weather] = 0
        end
        f[:weather].should be_between(0,100)

        if f[:rainfall] == -999
          f[:rainfall] = 0
        end
        f[:rainfall].should be_between(0,100)
      end
    end
  end

  describe '#forecast' do
    it 'returns forecast' do
      site.should respond_to(:forecast)

      # latlong = [lat, long]
      # forecast = nf.get_forecast(latlong)
      # site.forecast.should == forecast

      forecast = site.forecast

      forecast.each do |sub|
        sub.each do |data|
          if data == -999
            data = 0
          end
          data.should be_between(0,100)
        end
      end
    end
  end

  describe '#get_zipcode' do
    it 'returns zipcode' do
      site.should respond_to(:get_zipcode)
      site.get_zipcode.should == site.zipcode.to_s
    end
  end

  describe '#save_geo_coordinates' do
    it 'saves geo coordinates' do
      site.should respond_to(:save_geo_coordinates)
      site.save_geo_coordinates
      site.lat.should be_between(37,39)
      site.long.should be_between(121,123)
    end
  end
end
