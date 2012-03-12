require 'spec_helper'

describe "dashboard/index" do

  def site_attributes
    { :name => 'Foo bar', :zipcode => '94530' }
  end

  before(:each) do
    @user = Factory(:user)
    @p1 = Factory(:project)
    @p2 = Factory(:project)
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
      rendered.should =~ /Active Projects/
    end

    it "should show the Dashboard sidebar to signed in user" do
      render
      rendered.should have_selector('div#dashboard-sidebar')
    end

  end

end
