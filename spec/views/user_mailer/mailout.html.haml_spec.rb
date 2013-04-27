require 'spec_helper'

describe "user_mailer/mailout" do

	before(:all) do
    @greeting = "Greetings"
    @user = FactoryGirl.create(:user)
    @project = FactoryGirl.create(
      :project,
      :user => @user,
      )
    @projects = [ @project ]

    @site = FactoryGirl.create(
      :site,
      :project => @project,
      )
    @sites = [ @site ]

    @report = FactoryGirl.create(
      :report,
      :site => @site
    )
    @reports = [ @report ]

    @ie = FactoryGirl.create(
      :inspection_event,
      :site => @site
    )
    @pending_ie = [ @ie ]
  end

  it "renders mailout mailer" do
    render
    rendered.should have_selector 'h1', :text => 'Weekly Project Status'
    rendered.should =~ /Here are your pending tasks below./
  end

  it "renders pending reports" do
    render
    rendered.should have_text 'Report for'
    rendered.should_not have_text 'No pending reports'
  end

  it "renders pending inspections" do
    render
    rendered.should_not have_text 'No pending inspections'
  end
end
