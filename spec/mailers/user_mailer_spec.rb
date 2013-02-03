require "spec_helper"

describe UserMailer do

  before { ActionMailer::Base.deliveries = [] }

  before(:each) do
    @user = FactoryGirl.create(:user)
    @project = FactoryGirl.create(:project)
    @site = FactoryGirl.create(:site)

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

    # NOAA forecast stub copied from lib/weather spec.
    @fullcount = 29
    @nf = double(NOAAForecast)
    @nf.stub(:get_lat_long).with(94530).and_return([37.9202057, -122.2937428])
    @nf.stub(:ping_noaa).with([37.92, -122.29], 168, 6) do
      IO.read("./spec/lib/weather/noaa_response.xml")
    end
    @nf.stub(:get_forecast).with(@nf.get_lat_long(94530)) do
      response = @nf.ping_noaa([37.92, -122.29], 168, 6)
      nf = NOAAForecast.new(94530)
      nf.parse_weather_data(response)
    end
    @nf.stub(:seven_day_weather) do
      latlong = @nf.get_lat_long(94530)
      @nf.get_forecast(latlong)
    end
  end

  describe "pester_admins" do

    before(:each) do
      @receipient = "walter@stormsavvy.com"
      @mailer = UserMailer.mailout(@recipient).deliver

      @numusers = [@user]
      @numprojects = [@project]
      @numsites = [@site]

    end

    it "should send something via mailout" do
      ActionMailer::Base.deliveries.should_not be_empty
    end

    it "should render successfully" do
      lambda { @mailer }.should_not raise_error
    end

    it "should not have empty text body" do
      @mailer.body.should_not be_nil
      # @mailer.body.should have_selector("ul.projects")
      # @mailer.body.should have_selector("ul.sites")
      # @mailer.body.should have_selector('.chance-of-rain', :text => 'chance of rain')
    end

    it "renders user, project and site count" do
      @numprojects.should_not be_nil
      @numprojects.should_not be_nil
      @numusers.should_not be_nil
      @numsites.should_not be_nil
    end

    it "renders forecast table" do
      @nf.should_not be_nil
    end
  end

  describe "mailout mailer" do

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

    it "should have text in body" do
      @mailer.body.should_not be_empty
      # @mailer.body.should have_selector("ul.projects")
      # @mailer.body.should have_selector("ul.sites")
      # @mailer.body.should have_selector('.chance-of-rain', :text => 'chance of rain')
    end

    it "returns zipcodes" do
      @site1.zipcode.should == 94530
    end

    it "renders forecast table" do
      @nf.should_not be_nil
    end
  end

  describe "thank you mailer" do

    # TODO: Debug project factory table
    before(:each) do
      @receipient = "walter@stormsavvy.com"
      @mailer = UserMailer.thankyou(@recipient).deliver
    end

    it "should send something via mailout" do
      ActionMailer::Base.deliveries.should_not be_empty
    end

    it "should render successfully" do
      lambda { @mailer }.should_not raise_error
    end

    it "should have text in body" do
      @mailer.body.should_not be_empty
    end
  end

end
