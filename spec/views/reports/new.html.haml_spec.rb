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

  it "renders form partial correctly" do
    rendered.should =~ /New Report/
    rendered.should =~ /Site/
    rendered.should =~ /Inspection type/
    rendered.should =~ /Save/
    rendered.should =~ /Back/
  end

  describe 'file attachment partial' do
    before(:each) do
      assign(:reports, [
        stub_model(Report),
        stub_model(Report)
      ])
      @report = FactoryGirl.create(:report, :id => 1)
      render
    end

    it "renders partial correctly" do
      rendered.should_not be_nil
      rendered.should =~ /Instructions: Attach File & Complete Description Below/
      rendered.should =~ /Cancel/
    end
  end
end
