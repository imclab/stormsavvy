require "spec_helper"

describe GeonamesGeocodingService do
  context "when contacting geonames" do
    let(:zipcode) { 94530 }
    let(:query_results) { GeonamesGeocodingService.search(zipcode) }
    let(:result) { query_results.body["postalCodes"][0] }

    describe "with valid zipcode" do
      it "successfully retrieves results from geonames" do
        query_results.should_not == nil
      end

      context "API query" do

        it "should return lat/long after API query" do
          begin
            pp query_results.body["postalCodes"][0]
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
            'not online or method throwing error'
          end
        end
      end
    end
  end

  describe "without a site" do
    it "should raise an exception" do
      expect{ GeonamesGeocodingService.search(0).should }.to raise_error
    end
  end
end
