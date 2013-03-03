require 'spec_helper'

describe InspectionEventWorkflow do
  before(:each) do
    @iew = FactoryGirl.create(:inspection_event_workflow)
  end

  it "default model is valid" do
    @iew.should be_valid
  end

  it "should check on pre-storm inspection status 24 hours before rain" do
    @iew.hours_before_rain = 24
    @rew.chance_of_rain = 55
    @rew.pre_storm_inspection = false
    @rew.check_cem2030.should =~ /CEM2030 prepared/
  end

  it "should check on pre-storm inspection status 24 hours before rain" do
    @rew.hours_before_rain = 24
    @rew.chance_of_rain = 55
    @rew.reap = true
    @rew.check_reap.should_not =~ /Prepare CEM2030/
  end

  it "should check to see if rain is imminent" do
    @rew.hours_before_rain = 23
    @rew.chance_of_rain = 55
    @rew.reap = false
    lambda do
      if @rew.rain_imminent?
        @rew.start_inspection_event_workflow
      end
    end.should change(Report, :count).by(4) # double-count?
  end
end
