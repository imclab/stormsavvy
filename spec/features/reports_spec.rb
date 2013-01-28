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

    it "visits each pdf report path" do
      visit '/reports/CEM2030'
      current_path.should == reports_CEM2030_path

      visit reports_CEM2034_path
      current_path.should == reports_CEM2034_path

      visit reports_CEM2035_path
      current_path.should == reports_CEM2035_path

      visit reports_CEM2040_path
      current_path.should == reports_CEM2040_path

      visit reports_CEM2045_path
      current_path.should == reports_CEM2045_path

      visit reports_CEM2050_path
      current_path.should == reports_CEM2050_path

      visit reports_CEM2051_path
      current_path.should == reports_CEM2051_path

      visit reports_CEM2052_path
      current_path.should == reports_CEM2052_path

      visit reports_CEM4601_path
      current_path.should == reports_CEM4601_path
    end

    it "should GET /reports" do
      @report = FactoryGirl.build(:report)
      visit reports_path(:report => @report.id)
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
