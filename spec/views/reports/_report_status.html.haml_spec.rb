require 'spec_helper'

describe "reports/_report_status" do

  before(:each) do
    assign(:reports, [
      stub_model(Report),
      stub_model(Report)
    ])
  end

  it "renders report status partial correctly" do
    # visit reports_path
    # page.should_not be_nil
    render
    rendered.should =~ /Report Status/
    rendered.should =~ /Reports Needing Attention/
    rendered.should =~ /Completed Reports/
  end
end