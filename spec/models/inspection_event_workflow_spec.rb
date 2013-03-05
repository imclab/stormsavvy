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

  describe '#inspection_needed' do
    it "should check to see if inspection is needed" do
      lambda do
        if @iew.inspection_needed?
          @iew.start_inspection_event_workflow
        end
      end.should change(Report, :count).by(0) # double-count?
    end
  end

  describe '#check_inspection_event' do
    it 'creates new inspection event if none exists' do
      lambda do
        if @iew.check_inspection_event
          @iew.prepare_inspection_event
        end
      end.should change(InspectionEvent, :count).by(0) # change count later
    end
  end

  describe '#check_cem2023' do
    it 'creates new CEM2023 if none exists' do
      lambda do
        if @iew.check_cem2023
          @iew.prepare_cem2023
        end
      end.should change(Report, :count).by(0) # change count later
    end
  end

  describe '#check_cem2024' do
    it 'creates new CEM2024 if none exists' do
      lambda do
        if @iew.check_cem2024
          @iew.prepare_cem2024
        end
      end.should change(Report, :count).by(0) # change count later
    end
  end

  describe '#check_cem2030' do
    it 'creates new CEM2030 if none exists' do
      lambda do
        if @iew.check_cem2030
          @iew.prepare_cem2030
        end
      end.should change(Report, :count).by(0) # change count later
    end
  end

  describe '#check_cem2034' do
    it 'creates new CEM2034 if none exists' do
      lambda do
        if @iew.check_cem2034
          @iew.prepare_cem2034
        end
      end.should change(Report, :count).by(0) # change count later
    end
  end

  describe '#check_cem2035' do
    it 'creates new CEM2035 if none exists' do
      lambda do
        if @iew.check_cem2035
          @iew.prepare_cem2035
        end
      end.should change(Report, :count).by(0) # change count later
    end
  end

  describe '#check_cem2040' do
    it 'creates new CEM2040 if none exists' do
      lambda do
        if @iew.check_cem2040
          @iew.prepare_cem2040
        end
      end.should change(Report, :count).by(0) # change count later
    end
  end

end
