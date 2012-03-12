require 'spec_helper'

describe InspectionEvent do

  it "creates a valid Inspection Event" do
    ie = InspectionEvent.create!
    ie.should be_valid
  end
end
