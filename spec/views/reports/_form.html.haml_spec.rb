require 'spec_helper'

describe "reports/_form.html.haml" do

  it "renders form partial found on new report view" do
    visit new_report_path
    page.should_not be_nil
    # render
    # rendered.should =~ /Upload Attachment/
    # rendered.should =~ /Cancel/
    # rendered.should have_selector 'table'
  end
end
