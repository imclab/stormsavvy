require 'spec_helper'

describe "reports/index" do
  before(:each) do
    assign(:reports, [
      stub_model(Report),
      stub_model(Report)
    ])
  end

  it "renders index page correctly" do
    render
    rendered.should =~ /Report Status/
    rendered.should =~ /Reports Needing Attention/
    rendered.should =~ /Completed Reports/
  end
end
