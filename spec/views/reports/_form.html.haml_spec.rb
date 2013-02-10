require 'spec_helper'

describe "reports/_form" do

  before(:each) do
    assign(:reports, [
      stub_model(Report),
      stub_model(Report)
    ])
  end

  it "renders form partial correctly" do
    visit new_report_path
    page.should_not be_nil

    # render
    # rendered.should =~ /Upload Attachment/
    # rendered.should =~ /Cancel/
    # rendered.should have_selector 'table'
  end
end
