require 'spec_helper'

describe "reports/show" do
  before(:each) do
    assign(:reports, [
      stub_model(Report),
      stub_model(Report)
    ])

    @report = FactoryGirl.create(:report)
    # @project = assign(:project, stub_model(Project,
    #   :user_id => 1,
    #   :name => "Name",
    #   :description => "MyText",
    #   :active => false
    # ))
  end

  it "renders correct text" do
    render
    rendered.should =~ /View Report/
    rendered.should =~ /Delete This Report/

    rendered.should have_text('Report ID')
    rendered.should have_text('Report Date')
    rendered.should have_text('Site ID')
    rendered.should have_text('Inspection Type')
    rendered.should have_text('Status')
    rendered.should have_text('')
    rendered.should have_text('')

    rendered.should =~ /Download File/
    rendered.should =~ /Edit/
    rendered.should =~ /Back/
  end
end
