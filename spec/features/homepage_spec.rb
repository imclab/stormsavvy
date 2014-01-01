require 'spec_helper'

include ApplicationHelper
include Warden::Test::Helpers
Warden.test_mode!

describe "homepage" do

  let!(:user) { FactoryGirl.create(
    :user,
    :email => 'demo@stormsavvy.com',
    :password => 'savvy_demo',
    :password_confirmation => 'savvy_demo'
    )
  }

  describe 'signin page' do
    it "signs in as another user" do
      visit user_session_path
      current_path.should == '/users/sign_in'
      # current_path.should == '/index'
      # current_path.should == user_session_path
      fill_in 'Email', :with => 'barney@stormsavvy.com'
      fill_in 'Password', :with => 'foobarbaz'
      click_button 'Sign in'
      page.should have_content 'Invalid email or password'
    end

    it "renders correct links and pages after login" do
      visit user_session_path
      fill_in 'Email', :with => 'demo@stormsavvy.com'
      fill_in 'Password', :with => 'savvy_demo'
      click_button 'Sign in'
      page.should have_content 'Signed in successfully.'

      click_link "Inspections"
      current_path.should == inspection_events_path

      click_link "Settings"
      current_path.should == edit_user_registration_path

      click_link "Sign out"
      current_path.should == '/index'
      # current_path.should == '/users/sign_in'
    end
  end

  describe 'signup page' do
    it "signs up new user" do
      visit '/users/sign_up'
      fill_in 'Email', :with => 'demo2@stormsavvy.com'
      fill_in 'Password', :with => 'automate_workflow'
      fill_in 'Password confirmation', :with => 'automate_workflow'
      click_button 'Sign up'
      page.should have_content 'You have signed up successfully.'
    end
  end

  describe 'homepage' do

    it "renders landing page text" do
      visit index_path
      page.should have_text('Sign in')
      page.should have_text('Making SWPPP Easy')
      page.should have_text('Free Email Alerts & Reports')
      page.should have_text('Sign Up Now For Free Access')
    end

    it "renders correct links and pages from home page" do
      visit '/index'
      click_link "Privacy"
      current_path.should == privacy_path

      visit '/index'
      click_link "Terms"
      current_path.should == terms_path

      visit '/index'
      click_link "Sign in"
      current_path.should == new_user_session_path
    end
  end
end
