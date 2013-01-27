require 'spec_helper'

describe "InspectionEvents" do
  describe "GET /inspection_events" do
    it "visits inspection_events path" do
      visit inspection_events_path
      current_path.should == inspection_events_path
    end
  end
end
