require 'spec_helper'

describe 'inspection_events/_attachments' do

  before(:each) do
    assign(:inspection_events, [
      stub_model(InspectionEvent),
      stub_model(InspectionEvent)
    ])
    @inspection_event = FactoryGirl.create(:inspection_event, :id => 1)
  end
  
  it "renders partial correctly" do    
    render
    rendered.should_not be_nil
    rendered.should =~ /Instructions:/
    rendered.should =~ /Cancel/
  end
end
