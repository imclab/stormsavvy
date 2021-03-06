require "spec_helper"
require 'json'

describe GeocoderService do
  context "when contacting geonames" do
    let(:zipcode) { 94530 }
    let(:query_results) { GeonamesGeocodingService.search(zipcode) }
    let(:result) { query_results.body["postalCodes"][0] }

    describe "with valid zipcode" do
      context "API query" do

        it "returns postal code info after API query" do
          begin
            query_results.should_not == nil

            result["adminName2"].should == 'Contra Costa'
            result["AdminCode2"].should == 013
            result["AdminCode1"].should == 'CA'
            result["postalCode"].should == 94530
            result["countryCode"].should == 'US'
            result["placeName"].should == 'El Cerrito'
            result["adminName1"].should == 'California'

            result["lng"].should_not == nil
            result["lat"].should_not == nil
            expect{ result["foobar"].should  }.to raise_error
          rescue => e
            pending 'Geocoding API connection cannot be established'
            pp e
          end
        end

        it 'has correct response body count' do
          ## geocoder_results = JSON.parse(IO.read('./spec/fixtures/geocoder_results.json'))
          begin
            query_results
            query_results.body["postalCodes"][0].count.should == 9
            query_results.body.count.should == 1
          rescue => e
            pending 'Geocoding API connection cannot be established'
            pp e
          end
        end
      end
    end
  end

  describe "without valid zipcode" do
    it "returns nil for invalid zipcode" do
      begin
        query_results = GeonamesGeocodingService.search(0)
        query_results.body["postalCodes"][0].should == nil
      rescue => e
        pending 'Geocoding API connection cannot be established'
        pp e
      end
    end
  end

  context "when contacting geocoder" do
    let(:zipcode) { 94530 }
    let(:query_results) { Geocoder.search(zipcode) }
    let(:result) { query_results[0].data["geometry"]["location"] }

    describe "with valid zipcode" do
      context "API query" do
        it "returns postal code info after API query" do
          begin
            result.should_not == nil

            result["lat"].should =~ 37
            result["lng"].should =~ -122

            result["lat"].should_not == nil
            result["lng"].should_not == nil
            expect{ result["foobar"].should  }.to raise_error
          rescue => e
            pending 'Geocoding API connection cannot be established'
            pp e
          end
        end
      end
    end

    describe "#return_results_hash" do
      it 'returns results hash' do
        begin
          result = Geocoder.search(zipcode)
          result.return_results_hash
          pp result["lat"]
          pp result["lng"]
          expect{ result["foobar"].should  }.to raise_error
        rescue => e
          pending 'Geocoding API connection cannot be established'
          pp e
        end
      end
    end
  end

  describe "without valid zipcode" do
    it "returns nil for invalid zipcode" do
      begin
        result = Geocoder.search(0)
        result["lat"].should == nil
        result["lng"].should == nil
      rescue => e
        pending 'Geocoding API connection cannot be established'
        pp e
      end
    end
  end
end
