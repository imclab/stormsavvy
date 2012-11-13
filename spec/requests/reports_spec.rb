require 'spec_helper'

include ApplicationHelper

describe "Reports" do
	before :each do
		@user = FactoryGirl.create(
      :user,
      :email    => 'integration@stormsavvy.com',
      :password => 'automateyourspec!',
      :password_confirmation => 'automateyourspec!'
    )
		visit '/'
    click_link 'Sign in'
    fill_in 'Email', :with => 'integration@stormsavvy.com'
    fill_in 'Password', :with => 'automateyourspec!'
    click_button 'Sign in'
	end

  describe "GET /reports" do
    it "should GET /reports" do
      @report = FactoryGirl.build(:report)
      get reports_path(:report => @report.id)
    end

    it "should have correct content on homepage" do
      current_path.should == '/'
      page.should have_content('Storm Savvy')
      click_link 'Storm Savvy'
      page.should have_content('Storm Savvy')
    end

		it "should view and create new report" do
			current_path.should == '/'
			click_link 'CEM 2030'
			visit '/reports/new'
			current_path.should == '/reports/new'
			page.should have_content('New Report')
      click_button 'Save Report'
    end
  end
end
