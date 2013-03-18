require 'spec_helper'

describe InspectionEventWorkflow do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @project = FactoryGirl.create(
      :project,
      :user => @user
    )
    @site = FactoryGirl.create(
      :site,
      :project => @project
    )
    @iew = FactoryGirl.create(:inspection_event_workflow)
  end

  it "default model is valid" do
    @iew.should be_valid
  end

  describe "pre-storm inspection" do
    it "checks on pre-storm inspection status 24 hours before rain" do
      expect{
        @iew.hours_before_rain = 24
        @iew.chance_of_rain = 55
        @iew.pre_storm_inspection = false
        @iew.check_inspection_event
      }.to change(InspectionEvent.where(:completed => false), :count).by(1)
    end

    it "checks on pre-storm inspection status 24 hours before rain" do
      expect{
        @iew.hours_before_rain = 24
        @iew.chance_of_rain = 55
        @iew.pre_storm_inspection = true
        @iew.check_inspection_event
      }.to change(InspectionEvent.where(:completed => false), :count).by(1)
    end
  end

  describe '#check_inspection_event' do
    it 'creates new inspection event if none exists' do
      expect {
        @iew.inspection_event = false
        @iew.prepare_inspection_event
      }.to change(InspectionEvent, :count).by(1)
    end
  end

  describe '#check_cem2023' do
    it 'creates new CEM2023 if none exists' do
      expect {
        @iew.cem2023 = false
        @iew.prepare_cem2023
      }.to change(InspectionEvent.where(:completed => false), :count).by(1)
    end
  end

  describe '#check_cem2024' do
    it 'creates new CEM2024 if none exists' do
      expect {
        @iew.cem2024 = false
        @iew.prepare_cem2024
      }.to change(InspectionEvent.where(:completed => false), :count).by(1)
    end
  end

  describe '#check_cem2034' do
    it 'creates new CEM2034 if none exists' do
      expect {
        @iew.cem2034 = false
        @iew.prepare_cem2034
      }.to change(InspectionEvent.where(:completed => false), :count).by(1)
    end
  end

  describe '#check_cem2035' do
    it 'creates new CEM2035 if none exists' do
      expect {
        @iew.cem2035 = false
        @iew.prepare_cem2035
      }.to change(InspectionEvent.where(:completed => false), :count).by(1)
    end
  end

  describe '#check_cem2040' do
    it 'creates new CEM2040 if none exists' do
      expect {
        @iew.cem2040 = false
        @iew.prepare_cem2040
      }.to change(InspectionEvent, :count).by(1)
    end
  end
end
