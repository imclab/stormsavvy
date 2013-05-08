require 'spec_helper'

describe "reports/index" do
  before(:each) do
    @report = assign(:reports, [
      stub_model(Report),
      stub_model(Report)
    ])
    render
  end

  it "renders correct header text" do
    rendered.should =~ /Site ID/
    rendered.should =~ /Inspection Type/
    rendered.should =~ /Report ID/
    rendered.should =~ /Report Date/
    rendered.should =~ /Attachment URL/
  end

  it 'has new report button' do
    rendered.should have_link('New Report')
    rendered.should have_link('Show')
    rendered.should have_link('Edit')
    rendered.should have_link('Destroy')
  end
end
