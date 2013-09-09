require 'spec_helper'

describe SamplingEventWorkflow do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @project = FactoryGirl.create(
      :project,
      :user => @user
    )
    @site = FactoryGirl.create(
      :site,
      :id => 1,
      :project => @project
    )
    @se = FactoryGirl.create(
      :sampling_event,
      :site => @site,
      :site_id => 1
    )
    @sew = FactoryGirl.create(
      :sampling_event_workflow,
      :site => @site,
      :site_id => 1
    )
  end

  it "default model is valid" do
    @sew.should be_valid
  end

  describe '#check_cem2051' do
    xit "should add CEM2051 if status = false, 24 hours before rain" do
      expect{
        @sew.hours_before_rain = 24
        @sew.chance_of_rain = 55
        @sew.cem2051 = false
        @sew.check_cem2051
      }.to change(SamplingEvent, :count).by(1)

      # se = SamplingEvent.create(
      #   :completed => false
      # )
      # SamplingEvent.needs_attention.all.should == 1
      # @sew.check_cem2051.should =~ /CEM2051 prepared/
    end

    it "should not add CEM2051 if status = true, 24 hours before rain" do
      expect{
        @sew.hours_before_rain = 24
        @sew.chance_of_rain = 55
        @sew.cem2051 = true
        @sew.check_cem2051
      }.to change(SamplingEvent, :count).by(0)

      # @sew.check_cem2051.should_not =~ /Prepare CEM2051/
    end
  end

  describe '#check_cem2052' do
    xit "should add CEM2052 if status = false, 24 hours before rain" do
      expect{
        @sew.hours_before_rain = 24
        @sew.chance_of_rain = 55
        @sew.cem2052 = false
        @sew.check_cem2052
      }.to change(SamplingEvent, :count).by(1)

      # @sew.check_cem2052.should =~ /CEM2052 prepared/
    end

    it "should not add CEM2052 if status = true, 24 hours before rain" do
      expect{
        @sew.hours_before_rain = 24
        @sew.chance_of_rain = 55
        @sew.cem2052 = true
        @sew.check_cem2052
      }.to change(SamplingEvent, :count).by(0)

      # @sew.check_cem2052.should_not =~ /CEM2052 prepared/
    end
  end

  describe '#sampling_event' do
    it "checks to see if sampling is imminent" do
      expect{
        @sew.hours_before_rain = 23
        @sew.chance_of_rain = 55
        @sew.forecast_rain = 0.55
        @sew.sampling_event = false
      }.to change(SamplingEvent, :count).by(0)

      # lambda do
      #  if @sew.sampling_imminent?
      #    @sew.start_sampling_event_workflow
      #  end
      # end.should change(SamplingEvent, :count).by(1) # double-count?
    end

    it "should check to see whether it has rained" do
      @sew.amount_of_rain = 0.51
      @sew.has_rained?.should be_true
    end
  end
end
