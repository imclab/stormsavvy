require 'spec_helper'

describe "reports/_upload_file" do

  before(:each) do
    assign(:reports, [
      stub_model(Report),
      stub_model(Report)
    ])
    @report = FactoryGirl.create(:report, :id => 1)
  end
  
  it "renders upload_file partial correctly" do    
    render
    rendered.should_not be_nil
    rendered.should =~ /Instructions:/
    rendered.should =~ /Cancel/
  end
end
