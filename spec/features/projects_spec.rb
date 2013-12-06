require 'spec_helper'

include ApplicationHelper
include Devise::TestHelpers
include Warden::Test::Helpers
Warden.test_mode!

describe "Projects" do

  def valid_session
    { "warden.user.user.key" => session["warden.user.user.key"] }
  end

  before :each do
    @user = FactoryGirl.create(:user)
    login_as(@user, :scope => :user)
    visit new_project_path
  end

  describe "GET /projects", :type => :feature do

    it "correct content on homepage" do
      current_path.should == new_project_path
      page.should have_content('New Project')
      page.body.should_not be_nil
      click_link 'Storm Savvy'
      page.should have_selector('a', :text => 'Storm Savvy')
    end

  end

  describe 'Sites'do
  end
end
