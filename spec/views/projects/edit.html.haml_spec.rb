require 'spec_helper'

describe "projects/edit" do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @project = @user.projects.create!(
      {
        :name        => "MyString",
        :description => "MyText",
        :startdate   => 5.days.ago,
        :finishdate  => 1.day.ago,
        :active      => false
      }
    )
  end

  it "renders the edit project form" do
    render
    assert_select "form", :action => projects_path(@project), :method => "post" do
      assert_select "input#project_name", :name => "project[name]"
      # assert_select "input#project_start_date", :name => "project[start_date]"
      # assert_select "input#project_finish_date", :name => "project[finish_date]"
      assert_select "input#project_active", :name => "project[active]"
      assert_select "textarea#project_description", :name => "project[description]"
    end
  end
end
