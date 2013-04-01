require 'spec_helper'

describe "reports/edit" do

  before(:each) do
    assign(:reports, [
      stub_model(Report),
      stub_model(Report)
    ])
    @report = FactoryGirl.create(:report, :id => 1)
  end

  it "renders edit page correctly" do
    render
    rendered.should =~ /Site/
  end
end
