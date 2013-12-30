require 'spec_helper'

describe "projects/index" do

  let!(:user) { FactoryGirl.build(:user) }

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

    sign_in user
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
