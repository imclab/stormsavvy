require 'spec_helper'

describe "projects/new" do
  before(:each) do
    assign(:project, stub_model(Project,
      :user_id => 1,
      :name => "ec park and rec",
      :description => "playground improvements",
      :active => false
    ).as_new_record)
  end

  it "renders new project form" do
    render
    assert_select "form", :action => projects_path, :method => "post" do
      assert_select "input#project_name", :name => "project[name]"

      # possibly causing record not to save
      # assert_select "input#project_description", :name => "project[description]"
      assert_select "textarea#project_description", :name => "project[description]"

      assert_select "input#project_active", :name => "project[active]"
      assert_select "input#project_startdate", :name => "project[startdate]"
      assert_select "input#project_finishdate", :name => "project[finishdate]"
    end
  end
end
