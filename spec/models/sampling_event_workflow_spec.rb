require 'spec_helper'

describe SamplingEventWorkflow do
  before(:each) do
    @sew = FactoryGirl.create(:sampling_event_workflow)
  end

  it "default model is valid" do
    @sew.should be_valid
  end

  it "should check on CEM2051 status 24 hours before rain" do
    @sew.hours_before_rain = 24
    @sew.chance_of_rain = 55
    @sew.cem2051 = false
    @sew.check_cem2051.should =~ /CEM2051 prepared/
  end

  it "should check on CEM2051 status 24 hours before rain" do
    @sew.hours_before_rain = 24
    @sew.chance_of_rain = 55
    @sew.cem2051 = true
    @sew.check_reap.should_not =~ /Prepare CEM2051/
  end

  it "should check on CEM2052 status 24 hours before rain" do
    @sew.hours_before_rain = 24
    @sew.chance_of_rain = 55
    @sew.cem2052 = false
    @sew.check_cem2052.should =~ /CEM2030 prepared/    
  end

  it "should check on CEM2052 status 24 hours before rain" do
    @sew.hours_before_rain = 24
    @sew.chance_of_rain = 55
    @sew.cem2052 = true
    @sew.check_cem2052.should_not =~ /CEM2030 prepared/
  end
  
  it "should check to see if sampling is imminent" do
    @sew.hours_before_rain = 23
    @sew.chance_of_rain = 55
    @sew.forecast_rain = 0.55
    @rew.sampling_event = false
    lambda do
      if @rew.sampling_imminent?
        @rew.start_sampling_event_workflow
      end
    end.should change(SamplingEvent, :count).by(1)
  end

  it "should check to see whether it has rained" do
    @rew.amount_of_rain = 0.51
    @rew.has_rained?.should be_true
  end
end
