require 'spec_helper'

describe "WeatherEvents" do
  describe "GET /weather_events" do
    let!(:user) { FactoryGirl.create(:user) }

    it "visits weather_events path" do
      login_as(user, :scope => :user)
      visit weather_events_path
      current_path.should == weather_events_path
    end
  end
end
