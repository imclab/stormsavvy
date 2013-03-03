require 'spec_helper'

describe SamplingEventWorkflow do
  before(:each) do
    @sew = FactoryGirl.create(:sampling_event_workflow)
  end

  it "default model is valid" do
    @sew.should be_valid
  end
end
