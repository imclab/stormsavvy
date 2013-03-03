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
    @iew.chance_of_rain = 55
    @iew.pre_storm_inspection = false
    @iew.check_inspection_event.should =~ /Inspection event prepared/
  end

  it "should check on pre-storm inspection status 24 hours before rain" do
    @iew.hours_before_rain = 24
    @iew.chance_of_rain = 55
    @iew.pre_storm_inspection = true
    @iew.check_inspection_event.should_not =~ /Prepare inspection event/
  end

  xit "should check to see if rain is imminent" do
    @iew.hours_before_rain = 23
    @iew.chance_of_rain = 55
    @iew.reap = false
    lambda do
      if @iew.inspection_needed?
        @iew.start_inspection_event_workflow
      end
    end.should change(Report, :count).by(4) # double-count?
  end
end
