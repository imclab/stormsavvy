require 'spec_helper'

describe "InspectionEvents" do
  describe "GET /inspection_events" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get inspection_events_path
      response.status.should be(200)
    end
  end
end
