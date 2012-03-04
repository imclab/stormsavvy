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
    @rew.check_reap.should =~ /REAP prepared/
  end

  it "should check on CEM2045 status 48 hours before rain" do
    @rew.hours_before_rain = 48
    @rew.chance_of_rain = 55
    @rew.reap = true
    @rew.check_reap.should_not =~ /Prepare REAP/
  end

  it "should check on CEM2030 status 24 hours before rain" do
    @rew.hours_before_rain = 48
    @rew.chance_of_rain = 55
    @rew.reap = false
    @rew.check_cem2030.should =~ /CEM2030 prepared/    
  end

  it "should check on CEM2030 status 24 hours before rain" do
    @rew.hours_before_rain = 48
    @rew.chance_of_rain = 55
    @rew.cem2030 = true
    @rew.check_cem2030.should_not =~ /CEM2030 prepared/
  end
  
  it "should check to see if rain is imminent" do
    @rew.hours_before_rain = 23
    @rew.chance_of_rain = 55
    @rew.reap = false
    @rew.rain_imminent?.should =~ /CEM2030 prepared/
  end

end
