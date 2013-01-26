require 'spec_helper'

include ApplicationHelper

include Warden::Test::Helpers
Warden.test_mode!

describe "homepage" do

  before :each do
    @user = FactoryGirl.create(
      :user,
      :email    => 'testem@specit.com',
      :password => 'testem',
      :password_confirmation => 'testem'
      )
    # login_as(@user, :scope => :user)
  end

  it "renders sign-in page" do
    visit '/index'
    page.should have_content 'Sign in'
    click_link 'Sign in'
    current_path.should == '/users/sign_in'
  end

  it "signs user in with correct credentials" do
    visit '/users/sign_in' 
    fill_in 'Email', :with => 'testem@specit.com'
    fill_in 'Password', :with => 'testem'
    click_button 'Sign in'
    page.should have_content 'Signed in successfully.'
  end

  it "signs in as another user" do
    visit '/users/sign_in'
    fill_in 'Email', :with => 'barney@dinosaur.com'
    fill_in 'Password', :with => 'foobarbaz'
    click_button 'Sign in'
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
