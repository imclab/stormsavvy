require "spec_helper"
require "date"

include Warden::Test::Helpers
Warden.test_mode!

describe AlertMailer do
=begin
  let!(:user) { FactoryGirl.create(
      :user,
      :email => 'support@stormsavvy.com'
    )
  }
  let!(:project) { FactoryGirl.create(
      :project,
      :user => user,
      :name => 'ECP',
      :description => 'Plaza Improvements'
    )
  }
=end
  before { ActionMailer::Base.deliveries = [] }
  before(:each) do
    @user = FactoryGirl.create(
    # @user = User.create(
      :user,
      :firstname => 'Walter',
      :lastname => 'Yu',
      :email => 'walter@stormsavvy.com',
      :password => 'DarkAndStormy',
      :password_confirmation => 'DarkAndStormy'
      )
    @project = FactoryGirl.create(
      :project,
      :user => @user,
      :startdate => Date.today,
      :finishdate => Date.today + 30.days,
      :created_at => 1.day.ago
      )
    @site = FactoryGirl.create(
      :site,
      :project => @project,
      :name => 'ec jungle gym',
      :zipcode => 94530
      )
  end

  describe "#northbay_forecast" do
    before :each do
      @mailer = AlertMailer.northbay_forecast(@user.email).deliver
    end

    it "sets correct mailer settings" do
      # @mailer.greeting.should eq("Greetings")
      # @mailer.salutation.should eq("The Storm Savvy Team")
      # @mailer.support.should eq("Questions? Email us at info@stormsavvy.com!")
      # @mailer.noaa_info.should eq("Forecast is based on NOAA data feed. For more info, visit: ")

      @mailer.subject.should eq("Storm Savvy Daily Forecast: North Bay")
      @mailer.to.should eq(["#{@user.email}"])
      @mailer.from.should eq(["alerts@stormsavvy.com"])
    end

    it "renders the body" do
      @mailer.body.encoded.should =~ /Greetings/
      @mailer.body.encoded.should =~ /Listed below are the daily weather forecasts/
      @mailer.body.encoded.should =~ /Forecast is based on NOAA data feed/
      @mailer.body.encoded.should =~ /Email us at info@stormsavvy.com/
      @mailer.body.encoded.should =~ /The Storm Savvy Team/
    end

    it "delivers and receives mailer" do
      # AlertMailer.northbay_forecast(user)
      ActionMailer::Base.deliveries.should_not be_empty
    end
  end

  describe "#eastbay_forecast" do

    before :each do
      @mailer = AlertMailer.eastbay_forecast(@user.email).deliver
    end

    it "renders the headers" do
      # @mailer.greeting.should eq("The Storm Savvy Team")
      # @mailer.salutation.should eq("The Storm Savvy Team")
      # @mailer.support.should eq("Questions? Email us at info@stormsavvy.com!")
      # @mailer.noaa_info.should eq("Forecast is based on NOAA data feed. For more info, visit: ")

      @mailer.subject.should eq("Storm Savvy Daily Forecast: East Bay")
      @mailer.to.should eq(["#{@user.email}"])
      @mailer.from.should eq(["alerts@stormsavvy.com"])
    end

    it "renders the body" do
      @mailer.body.encoded.should =~ /Greetings/
      @mailer.body.encoded.should =~ /Listed below are the daily weather forecasts/
      @mailer.body.encoded.should =~ /Email us at info@stormsavvy.com/
      @mailer.body.encoded.should =~ /The Storm Savvy Team/
      # @mailer.body.encoded.should match("Greetings")
    end

    it "delivers and receives mailer" do
      # AlertMailer.eastbay_forecast(@user)
      ActionMailer::Base.deliveries.should_not be_empty
    end
  end

  describe "#southbay_forecast" do

    before :each do
      @user = FactoryGirl.create(:user, :email => "test@example.com")
      @mailer = AlertMailer.southbay_forecast(@user.email).deliver
    end

    it "renders the headers" do
      # @mailer.greeting.should eq("The Storm Savvy Team")
      # @mailer.salutation.should eq("The Storm Savvy Team")
      # @mailer.support.should eq("Questions? Email us at info@stormsavvy.com!")
      # @mailer.noaa_info.should eq("Forecast is based on NOAA data feed. For more info, visit: ")

      @mailer.subject.should eq("Storm Savvy Daily Forecast: South Bay")
      @mailer.to.should eq(["#{@user.email}"])
      @mailer.from.should eq(["alerts@stormsavvy.com"])
    end

    it "renders the body" do
      @mailer.body.encoded.should =~ /Greetings/
      @mailer.body.encoded.should =~ /Listed below are the daily weather forecasts/
      @mailer.body.encoded.should =~ /Email us at info@stormsavvy.com/
      @mailer.body.encoded.should =~ /The Storm Savvy Team/
    end

    it "delivers and receives mailer" do
      # AlertMailer.southbay_forecast(user)
      ActionMailer::Base.deliveries.should_not be_empty
    end
  end

  describe "noaa_alert" do
    before :each do
      @mailer = AlertMailer.noaa_alert(@user).deliver
    end

    it "renders the headers" do
      # @mailer.greeting.should eq("The Storm Savvy Team")
      # @mailer.salutation.should eq("The Storm Savvy Team")
      # @mailer.support.should eq("Questions? Email us at info@stormsavvy.com!")
      # @mailer.noaa_info.should eq("Forecast is based on NOAA data feed. For more info, visit: ")

      @mailer.subject.should =~ /Storm Savvy Daily/
      @mailer.to.should eq(["#{@user.email}"])
      @mailer.from.should eq(["alerts@stormsavvy.com"])
    end

    it "renders the body" do
      @mailer.body.encoded.should match("Greetings")
      @mailer.body.encoded.should =~ /Please be advised that there is a forecast rain event in your area./
    end

    it "delivers and receives mailer" do
      # AlertMailer.noaa_alert(@user)
      ActionMailer::Base.deliveries.should_not be_empty
    end
  end

  describe "noaa_forecast" do

    before(:each) do
      @user = FactoryGirl.create(:user, :email => "test@example.com")
      project = @user.projects.create(
        :name => "foo",
        :description => "bar",
        :startdate => Date.today,
        :finishdate => Date.today + 30.days
      )
      site = project.sites.build
      @mailer = AlertMailer.noaa_forecast(@user.email).deliver
    end

    it "should send something via mailout" do
      ActionMailer::Base.deliveries.should_not be_empty
    end

    it "should render successfully" do
      lambda { @mailer }.should_not raise_error
    end
  end
end
