require 'spec_helper'

describe "dashboard/index" do

  def site_attributes
    { :name => 'Foo bar', :zipcode => '94530' }
  end

  before(:each) do
    @user = FactoryGirl.create(:user)
    @p1 = FactoryGirl.create(:project)
    @p2 = FactoryGirl.create(:project)
    @projects = [@p1, @p2]
    @needs_attention_reports = Report.needs_attention
    #@s1 = @p1.sites.create(site_attributes)
    #@s2 = @p2.sites.create(site_attributes)
    sign_in @user
  end

  describe "index page components" do

    it "should show Active Projects to signed in user" do
      render
      rendered.should have_selector('div#modules')
      view.should render_template('dashboard/_modules')
      rendered.should =~ /Active Projects/
    end

    it "should show the Dashboard sidebar to signed in user" do
      render
      rendered.should have_selector('div#dashboard-sidebar')
      view.should render_template('dashboard/_sidebar')
    end

    it "Dashboard contains new report link" do
      render
      rendered.should have_selector('div#dashboard-sidebar')
      rendered.should =~ /New Report/
    end
  end
end
