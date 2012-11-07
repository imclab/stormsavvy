require 'spec_helper'

describe "Reports" do
	before :each do
		@user = FactoryGirl.create(
      :user,
      :email    => 'integration@stormsavvy.com',
      :password => 'automateyourspec!',
      :password_confirmation => 'automateyourspec!')
		visit '/'
    click_link 'Sign in'
    fill_in 'Email', :with => 'integration@stormsavvy.com'
    fill_in 'Password', :with => 'automateyourspec!'
    click_button 'Sign in'
	end

  describe "GET /reports" do
    it "should GET /reports" do
      @report = FactoryGirl.create(:report)
      # check report_path, @report.id not found
      get report_path(:report => @report.id) 
      # response.status.should be(200)
    end

    it "should have correct content on homepage" do
      current_path.should == '/'
      page.should have_content('Storm Savvy')
      click_link 'Storm Savvy'
      page.should have_content('Storm Savvy')
    end

		it "should view and create new report" do
			current_path.should == '/'
      # check current_path, user may not be logged in?
			click_link 'CEM 2030'

			visit '/reports/new'
			current_path.should == '/reports/new'
			page.should have_content('New Report')
      click_link 'Save Report'
    end
  end
end
