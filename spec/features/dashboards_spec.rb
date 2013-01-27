require 'spec_helper'

describe "Dashboards" do
  describe "GET /dashboards" do
    it "visits dashboards_path" do
      visit dashboards_path
      current_path.should = dashboards_path
    end
  end
end
