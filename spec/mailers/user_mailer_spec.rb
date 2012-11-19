require "spec_helper"

describe UserMailer do

  before { ActionMailer::Base.deliveries = [] }

  before(:each) do

    @user = FactoryGirl.create(:user)

    @project1 = @user.projects.new(
      :name => 'ec park and rec',
      :description => 'playground improvements',
      :startdate => DateTime.new(2011),
      :finishdate => DateTime.new(2012)
      )
    @project1.save

    @site1 = @project1.sites.new(
      :name => 'ec jungle gym',
      :zipcode => 94530
      )
    @site1.save

    @site2 = @project1.sites.new(
      :name => 'ec playground',
      :zipcode => 94530
      )
    @site2.save
  end

  describe "pester_admins" do

    before(:each) do
      @receipient = "walter@stormsavvy.com"
      @mailer = UserMailer.mailout(@recipient).deliver
    end

    it "should send something via mailout" do
      ActionMailer::Base.deliveries.should_not be_empty
    end

    it "should render successfully" do
      lambda { @mailer }.should_not raise_error
    end

    it "should have text body" do
      @mailer.body.should_not be_empty
    end
  end

  describe "mailout mailer" do

    # TODO: Debug project factory table
    before(:each) do
      @receipient = "walter@stormsavvy.com"
      @mailer = UserMailer.mailout(@recipient).deliver
    end

    it "should send something via mailout" do
      ActionMailer::Base.deliveries.should_not be_empty
    end

    it "should render successfully" do
      lambda { @mailer }.should_not raise_error
    end

    it "should have list of projects, site and POP" do
      @mailer.body.should have_selector("ul.projects")
      # @mailer.body.should have_selector("ul.sites")
      # @mailer.body.should have_selector('.chance-of-rain', :text => 'chance of rain')
    end
  end

  describe "noaa_forecast" do

    before(:each) do
      @receipient = "walter@stormsavvy.com"
      @mailer = UserMailer.noaa_forecast(@recipient).deliver
    end

    it "should send something via mailout" do
      ActionMailer::Base.deliveries.should_not be_empty
    end

    it "should render successfully" do
      lambda { @mailer }.should_not raise_error
    end

    it "should have list of projects, site and POP" do
      @mailer.body.should have_selector("ul.projects")
      # @mailer.body.should have_selector("ul.sites")
      # @mailer.body.should have_selector('.chance-of-rain', :text => 'chance of rain')
    end
  end

end
