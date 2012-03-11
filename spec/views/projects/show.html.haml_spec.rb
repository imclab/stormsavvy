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
    sign_in @user
  end

  xit "renders attributes in <p>" do
    render
    rendered.should match(/1/)
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
    rendered.should match(/false/)
  end
end
