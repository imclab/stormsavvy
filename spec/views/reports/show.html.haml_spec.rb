require 'spec_helper'

describe "reports/show" do
  before(:each) do
    assign(:reports, [
      stub_model(Report),
      stub_model(Report)
    ])

    # @project = assign(:project, stub_model(Project,
    #   :user_id => 1,
    #   :name => "Name",
    #   :description => "MyText",
    #   :active => false
    # ))
    @report = FactoryGirl.create(:report)
    # @user = FactoryGirl.create(:user)
    # @needs_attention_reports = Report.needs_attention
    # @sites = @project.sites
    # sign_in @user
  end

  it "renders edit / back / delete" do
    render
    rendered.should =~ /Edit/
    rendered.should =~ /Delete This Report/
    rendered.should =~ /Download PDF/
    rendered.should =~ /View Report/
  end
end
