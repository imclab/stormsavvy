require 'spec_helper'

describe "pages/index" do

=begin
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
=end

  describe "index page components" do

    it "renders cta-bar partial" do
      render
      # rendered.should have_selector('div#modules')
      view.should render_template('shared/_cta-bar')
      # rendered.should =~ /Active Projects/
    end

    it "renders maincopy partial" do
      render
      # rendered.should have_selector('div#dashboard-sidebar')
      view.should render_template('pages/_maincopy')
    end

    it "shows correct links on index page" do
      render
      rendered.should have_selector('div#homeContent')
      rendered.should =~ /Storm Savvy Tracker/
      rendered.should =~ /Storm Savvy PDF/
    end
  end
end
