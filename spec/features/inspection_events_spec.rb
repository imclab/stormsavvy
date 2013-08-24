require 'spec_helper'

describe "InspectionEvents" do
  describe "GET /inspection_events" do

    let(:user) {
      FactoryGirl.create(:user)
    }

    it "visits inspection_events path" do
      login_as(user, :scope => :user)
      visit inspection_events_path
      current_path.should == inspection_events_path
    end
  end
end
