require 'spec_helper'

describe "projects/show" do
  before(:each) do
    @project = assign(:project, stub_model(Project,
      :user_id => 1,
      :name => "Name",
      :description => "MyText",
      :active => false
    ))
    @user = Factory(:user)
    @needs_attention_reports = Report.needs_attention
    sign_in @user
  end

  it "renders attributes in <p>" do
    render
    rendered.should match(/1/)
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
    rendered.should match(/false/)
  end

  it "renders the project attributes" do
    render
    render.should have_selector('div#project-attributes')
  end

  it "renders the project sidebar" do
    render
    render.should have_selector('div#project-sidebar')
  end
end
