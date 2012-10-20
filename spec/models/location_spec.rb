require 'spec_helper'

describe Location do

  before(:each) do
    @location = FactoryGirl.create(:location)
  end

  it "should have a valid location" do
    @location.should be_valid
  end

  it "should geocode on the address" do
    location = Location.new({ :address_1 => '6016 B Avila St.',
                              :address_2 => '6016 B Avila St.',
                              :city      => 'El Cerrito',
                              :state     => 'CA',
                              :zipcode   => 94530 })
    location.should be_valid
    location.save
    location.lat.should  == 37.902889
    location.long.should == -122.304598
  end
end
