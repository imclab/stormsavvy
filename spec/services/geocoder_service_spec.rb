require "spec_helper"

describe GeocoderService do
  describe "with a valid zip code" do
    it "should return {:lat=>51.73796771, :lng=>19.41027467}" do
      service = GeocoderService.new(zipcode: 94109)
      service.get_lat_lng.should == {:lat=>51.73796771, :lng=>19.41027467}
    end

    it "should not return { lat: 0.0, lng: 0.0 }" do
      service = GeocoderService.new(zipcode: 94109)
      service.get_lat_lng.should_not == { lat: 0.0, lng: 0.0 }
    end
  end

  describe "with an invalid zip code" do
    it "should return { lat: 0.0, lng: 0.0 }" do
      service = GeocoderService.new(zipcode: 9999999)
      expect{ service.get_lat_lng.should }.to raise_error
    end
  end
end