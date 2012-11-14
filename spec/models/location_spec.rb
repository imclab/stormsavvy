require 'spec_helper'

describe Location do

  before(:each) do
    # @location = FactoryGirl.create(:location)
    @location = FactoryGirl.create({
      :address_1 => '6016 B Avila St.',
      :address_2 => '6016 B Avila St.',
      :city      => 'El Cerrito',
      :state     => 'CA',
      :zipcode   => 94530 
    })
  end

  it "should have a valid location" do
    @location.should be_valid
  end

  it "should geocode on the address" do
=begin
    location = Location.new({ :address_1 => '6016 B Avila St.',
                              :address_2 => '6016 B Avila St.',
                              :city      => 'El Cerrito',
                              :state     => 'CA',
                              :zipcode   => 94530 })
    location.should be_valid
    location.save
=end
    @location.lat.should  == 37.902889
    @location.long.should == -122.304598
  end
end
