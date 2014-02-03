require 'spec_helper'

include ApplicationHelper
include Devise::TestHelpers
include Warden::Test::Helpers
Warden.test_mode!

describe "Sites" do

  def valid_session
    { "warden.user.user.key" => session["warden.user.user.key"] }
  end

  let(:user) { FactoryGirl.build(
    :user,
    email: 'name@stormsavvy.com',
    password: 'stormpopwho?',
    password_confirmation: 'stormpopwho?'
    )
  }

  before :each do
    user.save!
    login_as(user, :scope => :user)
    visit root_path
  end

  describe "GET /sites" do
    it "saves the new site" do
      # fill_in 'Email', with: 'name@stormsavvy.com'#, :match => :prefer_exact
      # fill_in 'Password', with: 'stormpopwho?'#, :match => :prefer_exact
      # click_button 'Sign in'

      page.should have_content('Active Sites')
      page.should have_content('Weather Report')
      click_link 'New Site'
      current_path.should == new_site_path
      pp current_path

      fill_in 'Name', :with => 'ecp', :match => :prefer_exact
      fill_in 'Zipcode', :with => 94530
      click_button 'Save'

      page.should have_content('Site was successfully created.')
      current_path.should == '/sites/1'
    end
  end
end
