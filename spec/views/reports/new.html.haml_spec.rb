require 'spec_helper'

describe "reports/new" do
  before(:each) do
    assign(:report, stub_model(Report).as_new_record)
    render
  end

  it "renders new report fields" do
    assert_select "form", :action => reports_path, :method => "post" do
      assert_select "input#report_site_id", :name => "report[site_id]"
      assert_select "input#report_inspection_type", :name => "report[inspection_type]"
      assert_select "input#report_status", :name => "report[status]"
    end
  end
end
