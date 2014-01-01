require 'spec_helper'

describe RainEventWorkflow do

  let!(:rew) { FactoryGirl.create(:rain_event_workflow) }

  it "default model is valid" do
    rew.should be_valid
  end

  it "should check on CEM2045 status 48 hours before rain" do
    rew.hours_before_rain = 48
    rew.chance_of_rain = 55
    rew.reap = false
    rew.check_reap.should =~ /REAP prepared/
  end

  it "should check on CEM2045 status 48 hours before rain" do
    rew.hours_before_rain = 48
    rew.chance_of_rain = 55
    rew.reap = true
    rew.check_reap.should_not =~ /Prepare REAP/
  end

  it "should check on CEM2030 status 24 hours before rain" do
    rew.hours_before_rain = 24
    rew.chance_of_rain = 55
    rew.cem2030 = false
    # rew.reap = false
    rew.check_cem2030.should =~ /CEM2030 prepared/
  end

  it "should check on CEM2030 status 24 hours before rain" do
    rew.hours_before_rain = 24
    rew.chance_of_rain = 55
    rew.cem2030 = true
    rew.check_cem2030.should_not =~ /CEM2030 prepared/
  end

  it "should check to see if rain is imminent" do
    rew.hours_before_rain = 23
    rew.chance_of_rain = 55
    rew.reap = false
    lambda do
      if rew.rain_imminent?
        rew.start_rain_event_workflow
      end
    end.should change(Report, :count).by(0) # change report to sampling_event
  end

  it "should check to see whether it has rained" do
    rew.amount_of_rain = 0.51
    rew.has_rained?.should be_true
  end
end
