require "spec_helper"

include Warden::Test::Helpers
Warden.test_mode!

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

    before :each do
      @mailer = AlertMailer.pop_alert(@user).deliver
    end

    it "renders the headers" do
      @mailer.subject.should eq("Storm Savvy POP Alert")
      @mailer.to.should eq(["#{@user.email}"])
      @mailer.from.should eq(["alerts@stormsavvy.com"])
    end

    it "renders the body" do
      @mailer.body.encoded.should match("Greetings from StormSavvy")
    end

    it "delivers and receives mailer" do
      # AlertMailer.pop_alert(@user)
      ActionMailer::Base.deliveries.should_not be_empty
    end
  end

  describe "noaa_alert" do

    before :each do
      @mailer = AlertMailer.noaa_alert(@user).deliver
    end

    it "renders the headers" do
      @mailer.subject.should =~ /Storm Savvy Daily/
      @mailer.to.should eq(["#{@user.email}"])
      @mailer.from.should eq(["alerts@stormsavvy.com"])
    end

    it "renders the body" do
      @mailer.body.encoded.should =~ /Future mailer/
    end

    it "delivers and receives mailer" do
      # AlertMailer.noaa_alert(@user)
      ActionMailer::Base.deliveries.should_not be_empty
    end
  end

  describe "noaa_forecast" do

    before(:each) do
      @u = FactoryGirl.create(:user, :email => "test@example.com")
      p = @u.projects.create(:name => "foo", :description => "bar")
      s = p.sites.build
      @mailer = AlertMailer.noaa_forecast(@u.email).deliver
    end

    it "should send something via mailout" do
      ActionMailer::Base.deliveries.should_not be_empty
    end

    it "should render successfully" do
      lambda { @mailer }.should_not raise_error
    end

  end

end
