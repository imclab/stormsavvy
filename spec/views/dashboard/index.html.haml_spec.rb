require 'spec_helper'

describe "dashboard/index" do

  before(:each) do
    @user = Factory(:user)
    @project = Factory(:project)
  end
  
  xit "should show Active Projects to signed in user" do
    #sign_in @user
    render
    rendered.should =~ /Active Projects/
  end

end
