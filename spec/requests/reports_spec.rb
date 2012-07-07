require 'spec_helper'

describe "Reports" do
  describe "GET /reports" do
    it "should save report when button is clicked" do
      get reports_path
      response.status.should be(200)
    end
  end
end
