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

    it "shows active projects to signed in user" do
      render
      rendered.should have_selector('div#modules')
      view.should render_template('dashboard/_modules')
      rendered.should =~ /Active Projects/
    end

    it "shows sidebar to signed in user" do
      render
      rendered.should have_selector('div#dashboard-sidebar')
      view.should render_template('dashboard/_sidebar')
    end

    it "shows sidebar with correct titles" do
      render
      rendered.should have_selector('div#dashboard-sidebar')
      rendered.should =~ /New Report/
      rendered.should =~ /Pending Reports/
      rendered.should =~ /Report Forms/
    end
  end
end
