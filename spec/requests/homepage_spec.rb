require 'spec_helper'

include ApplicationHelper

include Warden::Test::Helpers
Warden.test_mode!

describe "homepage" do

  before :each do
    @user = FactoryGirl.create(
      :user,
      :email    => 'testem@spec.it',
      :password => 'testem',
      :password_confirmation => 'testem'
      )
    login_as(@user, :scope => :user)
  end

  it "renders sign-in page" do
    visit '/index'
    click_link "Sign in"
    current_path.should == '/users/sign_in'
  end

  it "signs user in with correct credentials" do
    visit '/users/sign_in'
    within("#session") do
      fill_in 'Login', :with => 'user@example.com'
      fill_in 'Password', :with => 'caplin'
    end
    click_link 'Sign in'
    page.should have_content 'Success'
  end

  it "signs in as another user" do
    visit '/users/sign_in'
    within("#session") do
      fill_in 'Login', :with => other_user.email
      fill_in 'Password', :with => other_user.password
    end
    click_link 'Sign in'
    page.should have_content 'Invalid email or password'
  end

=begin
  it "renders pdf form page" do
    visit '/index'
    click_link "Storm Savvy PDF"
    current_path.should == '/pdf'
  end

  it "renders index page from header link" do visit '/index'
    click_link "Storm Savvy"
    current_path.should == '/index'
  end

  it "renders index page from header link" do
    visit '/index'
    click_link 'Storm Savvy POP'
    visit 'http://pop.stormsavvy.com/'
    current_url.should == 'http://pop.stormsavvy.com/index'
  end
=end

end
