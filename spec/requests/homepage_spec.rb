require 'spec_helper'

include ApplicationHelper

include Warden::Test::Helpers
Warden.test_mode!

describe "homepage" do

  before :each do
    @user = FactoryGirl.create(
      :user,
      :email    => 'integration@stormsavvy.com',
      :password => 'automateyourspec!',
      :password_confirmation => 'automateyourspec!'
      )
    login_as(@user, :scope => :user)
    # visit '/index'
  end

  it "renders feature pages" do
    visit '/users/sign_in'
    current_path.should == '/users/sign_in'
    visit '/pdf'
    current_path.should == '/pdf'
    visit 'http://pop.stormsavvy.com/'
    current_path.should == 'http://pop.stormsavvy.com/'
  end
end
