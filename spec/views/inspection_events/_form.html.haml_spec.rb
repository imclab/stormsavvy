require 'spec_helper'

describe "inspection_events/_form" do

  before(:each) do
    assign(:sampling_events, [
      stub_model(InspectionEvent),
      stub_model(InspectionEvent)
    ])
  end

  it "renders form partial correctly" do
    # render
    # rendered.should =~ /Save/
    # rendered.should =~ /Back/
  end
end
