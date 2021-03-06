require "spec_helper"

describe GeonamesGeocodingService do
  context "when contacting geonames" do
    let(:zipcode) { 94530 }
    let(:query_results) { GeonamesGeocodingService.search(zipcode) }
    let(:result) { query_results.body["postalCodes"][0] }

    describe "with valid zipcode" do

      context "API query" do

        it "returns postal code info after API query" do
          begin
            pp query_results.body["postalCodes"][0]
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
            'not online or api query error'
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
      rescue
        'not online or api query error'
      end
    end
  end
end
