require 'spec_helper'

describe Location do

  before(:each) do
    @location = Factory(:location)
  end

  it "should have a valid location" do
    @location.should be_valid
  end

  it "should return coordinates given zipcode" do
    @location.lat.should == 37.9202057
  end
end
