require 'spec_helper'

describe "projects/edit" do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @project = FactoryGirl.create(
    # @project = @user.projects.create(
      :project,
      user: user,
      name: "ecp",
      description: "el plaza",
      startdate: 5.days.ago,
      finishdate: 1.day.ago,
      active: false
    )
  end

  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(
    :project,
    user:user,
    name: "ecp",
    description: "el plaza",
    startdate: 5.days.ago,
    finishdate: 1.day.ago,
    active: false,
    )
  }

  it "renders edit project form" do
    render
    assert_select "form", :action => projects_path(project), :method => "post" do
      assert_select "input#project_name", :name => "project[name]"
      assert_select "input#project_active", :name => "project[active]"
      assert_select "textarea#project_description", :name => "project[description]"
    end
  end
end
