require 'spec_helper'

describe Location do

  before(:each) do
    @location = Factory(:location)
  end

  xit "should have a valid location" do
    @location.should be_valid
  end

  xit "should return coordinates given zipcode" do
    @location.lat.should == 37.9202057
  end
end
