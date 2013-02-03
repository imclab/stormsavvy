require 'spec_helper'

describe "Dashboards" do
  describe "GET /dashboards" do
    it "visits dashboards_path" do
      visit dashboard_index_path
      current_path.should == index_path
    end
  end
end
