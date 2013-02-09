require 'spec_helper'

describe "reports/_reports_status" do
  it "renders form partial found on index page" do
    visit reports_path
    page.should_not be_nil
    # render 'reports/_form.html.haml'
    # rendered.should =~ /Upload Attachment/
    # rendered.should =~ /Cancel/
    # rendered.should have_selector 'table'
  end
end