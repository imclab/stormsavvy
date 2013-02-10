require 'spec_helper'

describe "reports/_show_file" do

  before(:each) do
    assign(:reports, [
      stub_model(Report),
      stub_model(Report)
    ])
    @report = FactoryGirl.create(:report, :id => 1)
  end
  
  it "renders show_file partial correctly" do    
    render
    rendered.should_not be_nil
    rendered.should =~ /Report ID/
    rendered.should =~ /Report Type/
    rendered.should =~ /Report Date/
  end
end
