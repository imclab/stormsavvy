require 'spec_helper'

describe 'sampling_events/_attachments' do

  before(:each) do
    assign(:sampling_events, [
      stub_model(SamplingEvent),
      stub_model(SamplingEvent)
    ])
    @sampling_event = FactoryGirl.create(:inspection_event, :id => 1)
  end
  
  it "renders partial correctly" do    
    render
    rendered.should_not be_nil
    rendered.should =~ /Instructions:/
    rendered.should =~ /Cancel/
  end
end
