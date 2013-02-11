require 'spec_helper'

describe "sampling_events/_form" do

  before(:each) do
    assign(:sampling_events, [
      stub_model(SamplingEvent),
      stub_model(SamplingEvent)
    ])
  end

  it "renders form partial correctly" do
    # render
    # rendered.should =~ /Save/
    # rendered.should =~ /Back/
    # rendered.should have_selector 'table'
  end
end
