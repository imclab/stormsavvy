require 'spec_helper'

describe Location do

  before(:each) do
    @location = FactoryGirl.create(:location)
  end

  it "should have a valid location" do
    @location.should be_valid
  end

  it "should geocode on the address" do
    @location.lat.should  == 37.902889
    @location.long.should == -122.304598
  end
end
