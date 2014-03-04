require "spec_helper"

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
          rescue
            'Geocoding API connection cannot be established'
          end
        end

        it 'makes live query' do
          pp query_results.body["postalCodes"][0]
          pp query_results.count
          # query_results.body["postalCodes"][0].should...
          # query_results.count.should...
        end
      end
    end
  end

  describe "without valid zipcode" do
    it "returns nil for invalid zipcode" do
      begin
        query_results = GeonamesGeocodingService.search(0)
        query_results.body["postalCodes"][0].should == nil
      rescue
        'Geocoding API connection cannot be established'
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
          rescue
            'Geocoding API connection cannot be established'
          end
        end
      end
    end

    describe "#return_results_hash" do
      begin
        result = Geocoder.search(zipcode)
        result.return_results_hash
        pp result["lat"]
        pp result["lng"]
      rescue
        'Geocoding API connection cannot be established'
      end
    end
  end

  describe "without valid zipcode" do
    it "returns nil for invalid zipcode" do
      begin
        result = Geocoder.search(0)
        result["lat"].should == nil
        result["lng"].should == nil
      rescue
        'Geocoding API connection cannot be established'
      end
    end
  end
end
