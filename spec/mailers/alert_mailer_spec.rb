require 'spec_helper'
require 'date'

include Warden::Test::Helpers
Warden.test_mode!

describe AlertMailer do

  before {
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
  }

  after {
    ActionMailer::Base.deliveries.clear
  }

  let!(:user) {
    FactoryGirl.build(
      :user,
      firstname: 'yoda',
      lastname: 'jedi',
      email: 'yoda@starwars.com'
    )
  }
  let!(:site) {
    FactoryGirl.create(
      :site,
      user: user
    )
  }

  describe "#northbay_forecast" do
    let!(:mailer) { AlertMailer.northbay_forecast(user.email).deliver }

    it "sets correct settings" do
      mailer.subject.should eq("Storm Savvy Daily Forecast: North Bay")
      mailer.to.should eq(["#{user.email}"])
      mailer.from.should eq(["alerts@stormsavvy.com"])
    end

    it "renders body" do
      mailer.body.encoded.should match("Greetings")
      mailer.body.encoded.should match("Listed below are the daily weather forecasts")
      mailer.body.encoded.should match("Please email walter@stormsavvy.com")
      mailer.body.encoded.should match("The Storm Savvy Team")
    end

    it "delivers mailer" do
      ActionMailer::Base.deliveries.count.should == 1
      ActionMailer::Base.deliveries.should_not be_empty
    end

    it 'delays delivery using sidekiq' do
      expect { AlertMailer.delay.northbay_forecast(user.email)}.to change(
        Sidekiq::Extensions::DelayedMailer.jobs, :size
      ).by(1)
    end
  end

  describe "daily_mailer" do
    let!(:mailer) { AlertMailer.daily_mailer(user).deliver }

    it "renders headers" do
      mailer.subject.should eq("Storm Savvy Daily Mailer for #{ProjectLocalTime::date_only(Date.today)}")
      mailer.to.should eq(["#{user.email}"])
      mailer.from.should eq(["alerts@stormsavvy.com"])
    end

    it "renders body" do
      mailer.body.encoded.should match("Greetings")
      mailer.body.encoded.should match("Please email walter@stormsavvy.com")
      mailer.body.encoded.should match("The Storm Savvy Team")
    end

    it 'creates noaa forecast table' do
      nfs = NoaaForecastService.new(site: site)
      forecast = nfs.forecast_table(site)
      nfs.should respond_to(:forecast_table)
      forecast.each do |f|
        f[:weather].should be_between(0,100)
        f[:rainfall].should be_between(0,100)
      end
    end

    it 'creates wunderground forecast' do
      wg = WeatherGetter.new
      forecast = wg.get_forecast(site.zipcode)
      wg.should respond_to(:get_forecast)

      forecastday = wg.parse_wunderground_10day(forecast)
      forecastday.count.should == 10

      forecastday.each do |f|
        f['pop'].should be_between(0,100)
      end
    end

    it "delivers mail" do
      ActionMailer::Base.deliveries.count.should == 1
      ActionMailer::Base.deliveries.should_not be_empty
    end

    it "renders successfully" do
      lambda { mailer }.should_not raise_error
    end

    it 'delays delivery using sidekiq' do
      expect { AlertMailer.delay.daily_mailer(user.email)}.to change(
        Sidekiq::Extensions::DelayedMailer.jobs, :size
      ).by(1)
    end
  end

  describe "pop_alert" do
    let!(:mailer) { AlertMailer.pop_alert(user, site).deliver }

    it "renders headers" do
      mailer.subject.should =~ /Storm Savvy POP Alert/
      mailer.to.should eq(["#{user.email}"])
      mailer.from.should eq(["alerts@stormsavvy.com"])
    end

    it "delivers mailer" do
      ActionMailer::Base.deliveries.count.should == 1
      ActionMailer::Base.deliveries.should_not be_empty
    end

    it "renders successfully" do
      lambda { mailer }.should_not raise_error
    end

    it 'delays delivery using sidekiq' do
      expect { AlertMailer.delay.pop_alert(user.email)}.to change(
        Sidekiq::Extensions::DelayedMailer.jobs, :size
      ).by(1)
    end
  end
end
