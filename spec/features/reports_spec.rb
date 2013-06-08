require 'spec_helper'

include ApplicationHelper
include Warden::Test::Helpers
Warden.test_mode!

describe "Reports" do

	before :each do
		@user = FactoryGirl.create(
      :user,
      :email    => 'testem@stormsavvy.com',
      :password => 'specit!',
      :password_confirmation => 'specit!'
    )
    login_as(@user, :scope => :user)
    visit '/reports'
  end

  describe "GET /reports", :type => :feature do

    it "visits reports path" do
      current_path.should == '/reports'
    end

    it "should GET /reports" do
      @report = FactoryGirl.build(:report)
      visit reports_path(:report => @report.id)
      Warden.test_reset!
    end

		it "shows upload page" do
			visit new_report_path
      page.body.should_not be_nil
      page.should ~ /Instructions: Select Report For Upload Below/
    end

		it "returns to reports path if cancelled" do
			visit new_report_path
      page.body.should_not be_nil
      click_link 'Cancel'
      current_path.should == reports_path
			# page.body.should have_selector('h2', :text => 'View Report')
      # current_path.should == report_path(1)
    end
  end
end
