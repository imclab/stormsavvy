require 'spec_helper'

describe Location do

  before(:each) do
    @location = Factory(:location)
  end

  it "should have a valid location" do
    @location.should be_valid
  end
end
