require 'spec_helper'

include ApplicationHelper

include Warden::Test::Helpers
Warden.test_mode!

describe "homepage" do

  before :each do
    # @user = FactoryGirl.create(
    #   :user,
    #   :email    => 'integration@stormsavvy.com',
    #   :password => 'automateyourspec!',
    #   :password_confirmation => 'automateyourspec!'
    #   )
    # login_as(@user, :scope => :user)
  end

  it "renders feature pages" do
    visit '/'
    click_link 'Storm Savvy Tracker'
    # visit '/users/sign_in'
    current_path.should == '/users/sign_in'

    visit '/pdf'
    current_path.should == '/pdf'

    # visit '/index'
    # click_link 'Storm Savvy POP'
    # visit 'http://pop.stormsavvy.com/'
    # current_url.should == 'http://pop.stormsavvy.com/index'
  end
end
