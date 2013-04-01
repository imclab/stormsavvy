require 'spec_helper'

describe Location do

  before(:each) do
    @location = FactoryGirl.create(:location)
  end

  it "should have a valid location" do
    @location.should be_valid
  end
end
