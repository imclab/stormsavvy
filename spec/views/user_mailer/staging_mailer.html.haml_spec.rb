require 'spec_helper'

describe "user_mailer/staging_mailer" do

  before(:all) do
    @greeting = "Greetings"

    @user = FactoryGirl.create(:user)
    @project1 = FactoryGirl.create(
      :project,
      :user => @user,
      :created_at => 1.day.ago
      )
    @project2 = FactoryGirl.create(
      :project,
      :user => @user,
      :created_at => 1.hour.ago
      )
    @projects = [@project1, @project2]

    @site1 = FactoryGirl.create(
      :site,
      :project => @project1,
      :name => 'ec jungle gym',
      :zipcode => 94530
      )
    @site2 = FactoryGirl.create(
      :site,
      :project => @project2,
      :name => 'ec playground slide',
      :zipcode => 94530
      )
    @sites = [@site1, @site2]
  end

  it "renders stagingi_mailer" do
    render
    rendered.should have_selector 'h1', :text => 'Storm Savvy Staging App Email'
    rendered.should =~ /Storm Savvy Staging App Email/
  end
end
