require 'spec_helper'

include ApplicationHelper
include Devise::TestHelpers
include Warden::Test::Helpers
Warden.test_mode!

describe "Sites" do

  def valid_session
    { "warden.user.user.key" => session["warden.user.user.key"] }
  end

  let(:user) { FactoryGirl.build(:user) }

  before :each do
  end

  describe "GET /sites" do
    it "saves the new site" do
      visit root_path
      login_as(user, :scope => :user)

      # visit new_site_path
      page.should have_content('New Site')
      click_link 'New Site'
      current_path.should == new_site_path
      fill_in 'Name', :with => 'ecp', :match => :prefer_exact
      fill_in 'Zipcode', :with => 94530
      click_button 'Save'

      page.should have_content('Site was successfully created.')
      current_path.should == '/sites/1'
    end
  end
end
