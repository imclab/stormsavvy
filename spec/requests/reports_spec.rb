require 'spec_helper'

include ApplicationHelper

include Warden::Test::Helpers
Warden.test_mode!

describe "Reports" do
	before :each do
		@user = FactoryGirl.create(
      :user,
      :email    => 'integration@stormsavvy.com',
      :password => 'automateyourspec!',
      :password_confirmation => 'automateyourspec!'
    )
    login_as(@user, :scope => :user)
    visit '/reports'
	end

  describe "GET /reports", :type => :feature do


    it "should have correct content on homepage" do
      current_path.should == '/reports'
      #page.should have_content('Storm Savvy')
      click_link 'Storm Savvy'
      page.should have_selector('a', :text => 'Storm Savvy')
    end

    it "should GET /reports" do
      @report = FactoryGirl.build(:report)
      get reports_path(:report => @report.id)
      Warden.test_reset!
    end

		it "should view and create new report" do
			visit '/reports/new'
      page.body.should_not be_nil
			page.body.should have_selector('h2', :text => 'New Report')
    end

		it "saves the new report" do
			visit '/reports/new'
      page.body.should_not be_nil
      click_button 'Save Report'
			page.body.should have_selector('h2', :text => 'View Report')
      current_path.should == report_path(1)
    end

  end
end
