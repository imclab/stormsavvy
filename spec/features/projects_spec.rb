require 'spec_helper'

include ApplicationHelper
include Devise::TestHelpers
include Warden::Test::Helpers
Warden.test_mode!

describe "Projects" do

  def valid_session
    { "warden.user.user.key" => session["warden.user.user.key"] }
  end

  describe "GET /projects", :type => :feature do
    before :each do
      @user = FactoryGirl.create(:user)
      login_as(@user, :scope => :user)
      visit new_project_path
    end

    it "correct content on homepage" do
      current_path.should == new_project_path
      page.should have_content('New Project')
      page.body.should_not be_nil
      click_link 'Storm Savvy'
      page.should have_selector('a', :text => 'Storm Savvy')
    end

		it "saves the new project" do
      visit new_project_path
      current_path.should == new_project_path
      page.should have_content('New Project')
      fill_in 'Name', :with => 'ECP Improvements', :match => :prefer_exact
      fill_in 'Description', :with => 'Jungle Gym, etc.', :match => :prefer_exact
      click_button 'Create Project'

      page.should have_content('Project was successfully created.')
      # current_path.should == '/projects'
      current_path.should == projects_path

      pp @user.projects
      pp @user.email
    end
  end
end
