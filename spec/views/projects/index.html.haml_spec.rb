require 'spec_helper'

describe "projects/index" do

  before(:each) do
    assign(:projects, [
      stub_model(Project,
        :user_id => 1,
        :name => "Name",
        :description => "MyText",
        :active => false
      ),
      stub_model(Project,
        :user_id => 1,
        :name => "Name",
        :description => "MyText",
        :active => false
      )
    ])
  end

  it "renders the project attributes" do
    render
    render.should have_selector('div#all-projects')
  end

  it "renders the project sidebar" do
    render
    render.should have_selector('div#projects-sidebar')
  end
end
