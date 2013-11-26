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
      :user => @user
      # :project => @project,
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
    rendered.should have_selector 'h2', :text => 'Pending Reports'
    rendered.should have_selector 'h2', :text => 'Pending Inspections'
    rendered.should =~ /Here are your pending tasks below./
  end

  it "renders pending reports" do
    render
    rendered.should have_text "Report for #{@report.created_at}"
    rendered.should_not have_text 'No pending reports'
  end

  it "renders pending inspections" do
    render
    rendered.should have_text "#{@ie.inspection_type} for #{@ie.site.name} on #{@ie.inspection_date}"
    rendered.should_not have_text 'No pending inspections'
  end
end
