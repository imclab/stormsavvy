require "spec_helper"

describe AlertMailer do

  before { ActionMailer::Base.deliveries = [] }

  before(:each) do
    # @user = FactoryGirl.create(:user)
    @user = User.create!(
      :firstname              => 'Walter',
      :lastname               => 'Yu',
      :email                  => 'walter@stormsavvy.com',
      :password               => 'DarkAndStormy',
      :password_confirmation  => 'DarkAndStormy'
      )
  end

  describe "pop_alert" do
    let(:mail) { AlertMailer.pop_alert }

    it "renders the headers" do
      mail.subject.should eq("Storm Savvy POP Alert")
      mail.to.should eq(["#{@user.login} <#{@user.email}>"])
      mail.from.should eq(["alerts@stormsavvy.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Greetings")
    end

  end

  it "should send Pop Alert emails" do
    AlertMailer.pop_alert(@user).deliver
    ActionMailer::Base.deliveries.should_not be_empty
  end

  it "should send NOAA Alert emails" do
    AlertMailer.noaa_alert(@user).deliver
    ActionMailer::Base.deliveries.should_not be_empty
  end

end
