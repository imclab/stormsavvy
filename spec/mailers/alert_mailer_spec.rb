require 'spec_helper'
require 'date'

include Warden::Test::Helpers
Warden.test_mode!

describe AlertMailer do

  before { ActionMailer::Base.deliveries = [] }

  let!(:user) { FactoryGirl.build(
    :user
    )
  }
  let!(:site) { FactoryGirl.create(
    :site,
    :user => user
    )
  }

  describe "#northbay_forecast" do
    let!(:mailer) { AlertMailer.northbay_forecast(user.email).deliver }

    it "sets correct mailer settings" do
      mailer.subject.should eq("Storm Savvy Daily Forecast: North Bay")
      mailer.to.should eq(["#{user.email}"])
      mailer.from.should eq(["alerts@stormsavvy.com"])
    end

    it "renders the body" do
      mailer.body.encoded.should match("Greetings")
      mailer.body.encoded.should match("Listed below are the daily weather forecasts")
      mailer.body.encoded.should match("Email us at walter@stormsavvy.com")
      mailer.body.encoded.should match("The Storm Savvy Team")
    end

    it "delivers and receives mailer" do
      ActionMailer::Base.deliveries.should_not be_empty
    end

    it 'delays delivery using sidekiq' do
      expect { AlertMailer.delay.northbay_forecast(user.email)}.to change(
        Sidekiq::Extensions::DelayedMailer.jobs, :size
      ).by(1)
    end
  end

  describe "daily_mailer" do
    let!(:user) {
      FactoryGirl.create(
        :user,
        email: 'walter@stormsavvy.com'
      )
    }
    let!(:site) {
      FactoryGirl.create(
        :site,
        user: user
      )
    }
    let!(:mailer) { AlertMailer.noaa_forecast(user).deliver }

    it "renders the headers" do
      mailer.subject.should eq("Storm Savvy Daily Mail for #{ProjectLocalTime::date_only(Date.today)}")
      mailer.to.should eq(["#{user.email}"])
      mailer.from.should eq(["alerts@stormsavvy.com"])
    end
    @site_pop = []

    it "renders the body" do
      mailer.body.encoded.should match("Greetings")
      mailer.body.encoded.should match("Email us at walter@stormsavvy.com")
      mailer.body.encoded.should match("The Storm Savvy Team")
    end

    it "delivers mail" do
      ActionMailer::Base.deliveries.should_not be_empty
    end

    it "renders successfully" do
      lambda { mailer }.should_not raise_error
    end

    it 'delays delivery using sidekiq' do
      expect { AlertMailer.delay.noaa_forecast(user.email)}.to change(
        Sidekiq::Extensions::DelayedMailer.jobs, :size
      ).by(1)
    end
  end

  describe "pop_alert" do
    let!(:mailer) { AlertMailer.pop_alert(user.email).deliver }

    it "renders the headers" do
      mailer.subject.should =~ /Storm Savvy POP Alert/
      mailer.to.should eq(["#{user.email}"])
      mailer.from.should eq(["alerts@stormsavvy.com"])
    end

    it "sends something via mailout" do
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
