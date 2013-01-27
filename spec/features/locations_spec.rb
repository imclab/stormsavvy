require 'spec_helper'

describe "Locations" do
  describe "GET /locations" do
    it "visits locations path" do
      visit locations_path
      current_path.should == locations_path
    end
  end
end
