require 'spec_helper'

describe RainEventWorkflow do
  
  before(:each) do
    @rew = Factory(:rain_event_workflow)
  end

  it "default model is valid" do
    @rew.should be_valid
  end

  it "should check on CEM2045 status 48 hours before rain" do
    @rew.hours_before_rain = 48
    @rew.chance_of_rain = 55
    @rew.reap = false
    @rew.check_reap.should =~ /Prepare REAP/
  end
 
end
