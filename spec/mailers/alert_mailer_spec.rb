require "spec_helper"

describe AlertMailer do

  before { ActionMailer::Base.deliveries = [] }

  before(:each) do
    # TODO: Debug user factory table
    # @user = FactoryGirl.create(:user)
    @user = User.create(
      :firstname              => 'Walter',
      :lastname               => 'Yu',
      :email                  => 'walter@stormsavvy.com',
      :password               => 'DarkAndStormy',
      :password_confirmation  => 'DarkAndStormy'
      )
    @project = FactoryGirl.create(
      :project, 
      :user => @user, 
      :created_at => 1.day.ago
      )
    @site = FactoryGirl.create(
      :site, 
      :project => @project, 
      :name => 'ec jungle gym', 
      :zipcode => 94530
      )
  end

  describe "pop_alert" do

    # TODO: Debug printing loop when pop_alert is called.
    let(:mail) { 
      AlertMailer.pop_alert(@user)#.deliver 
    }

    it "renders the headers" do
      mail.subject.should eq("Storm Savvy POP Alert")
      mail.to.should eq(["#{@user.email}"])
      mail.from.should eq(["alerts@stormsavvy.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Greetings")
    end

    it "delivers and receives mailer" do
      AlertMailer.pop_alert(@user)#.deliver
      ActionMailer::Base.deliveries.should_not be_empty
    end
  end

  it "should send NOAA Alert emails" do
    AlertMailer.noaa_alert(@user)#.deliver
    ActionMailer::Base.deliveries.should_not be_empty
  end

end
