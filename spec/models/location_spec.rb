require 'spec_helper'

describe Location do

  let!(:location) { FactoryGirl.create(:location) }

  it "should have a valid location" do
    location.should be_valid
  end
end
