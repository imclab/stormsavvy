require 'spec_helper'

describe "reports/_cem2030" do

  before(:each) do
    assign(:reports, [
      stub_model(Report),
      stub_model(Report)
    ])
    @report = FactoryGirl.create(:report, :id => 1)
  end

  it "renders cem2030 partial correctly" do
    render
    rendered.should_not be_nil
    rendered.should =~ /Weekly Inspection/
    rendered.should =~ /Page 1/
  end
end
