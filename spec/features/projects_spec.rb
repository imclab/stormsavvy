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

    describe 'Sites'do
      it "saves the new project" do
        visit root_path
        click_link 'New Site'

        # visit new_site_path
        current_path.should == new_site_path
        page.should have_content('New Site')
        fill_in 'Name', :with => 'ECP Improvements', :match => :prefer_exact
        fill_in 'Description', :with => 'Jungle Gym, etc.', :match => :prefer_exact
        fill_in 'Zipcode', :with => 94530
        click_button 'Save'

        page.should have_content('Site was successfully created.')
        current_path.should == site_path

        pp @user.projects
        pp @user.email
      end
    end
  end
end
