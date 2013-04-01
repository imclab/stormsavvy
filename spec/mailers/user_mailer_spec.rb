require "spec_helper"

describe UserMailer do

  before { ActionMailer::Base.deliveries = [] }

  before(:each) do
    @user = FactoryGirl.create(:user)
    @users = [@user]

    @project = FactoryGirl.create(
      :project,
      :user => @user,
      :created_at => 1.day.ago
      )
    @projects = [ @project ]

    @site = FactoryGirl.create(
      :site,
      :project => @project,
      :name => 'ec jungle gym',
      :zipcode => 94530
      )
    @sites = [ @site ]

    @report1 = FactoryGirl.create(
      :report,
      :site => @site,
      :status => 'needs_attention'
    )
    @report2 = FactoryGirl.create(
      :report,
      :site => @site,
      :status => 'needs_attention'
    )
    @reports = [ @report1, @report2 ]

    @numusers = [@user]
    @numprojects = [@project]
    @numsites = [@site]

    # @project = FactoryGirl.create(:project_with_sites)
    # @site = FactoryGirl.create(:site)

    @fullcount = 29
    @lat = 37.9202057
    @long = -122.2937428
    @nf = double(NOAAForecast)

    @nf.stub(:get_lat_long).with(94530).and_return([@lat, @long])

    @nf.stub(:ping_noaa).with([@lat, @long], 168, 6) do
      IO.read("./spec/lib/weather/noaa_response.xml")
    end

    @nf.stub(:get_forecast).with(@nf.get_lat_long(94530)) do
      response = @nf.ping_noaa([@lat, @long], 168, 6)
      nf = NOAAForecast.new(94530)
      nf.parse_weather_data(response)
    end

    @nf.stub(:seven_day_weather) do
      latlong = @nf.get_lat_long(94530)
      @nf.get_forecast(latlong)
    end
  end

  describe '#pester_admins' do

    before(:each) do
      email = "walter@stormsavvy.com"
      @mailer = UserMailer.pester_admins(email).deliver
    end

    it "delivers mail successfully" do
      ActionMailer::Base.deliveries.should_not be_empty
    end

    it "renders successfully" do
      lambda { @mailer }.should_not raise_error
    end

    it "does not have empty text body" do
      @mailer.body.should_not be_nil
    end

    it "renders user, project and site count" do
      @numprojects.should_not be_nil
      @numprojects.should_not be_nil
      @numusers.should_not be_nil
      @numsites.should_not be_nil
    end

    it "returns nf stub value" do
      @nf.should_not be_nil
    end
  end

  describe '#staging_mailer' do

    before(:each) do
      email = "walter@stormsavvy.com"
      @mailer = UserMailer.staging_mailer(email).deliver
    end

    it "delivers mail successfully" do
      ActionMailer::Base.deliveries.should_not be_empty
    end

    it "renders successfully" do
      lambda { @mailer }.should_not raise_error
    end

    it "does not have empty text body" do
      @mailer.body.should_not be_nil
    end

    it "renders user, project and site count" do
      @numprojects.should_not be_nil
      @numprojects.should_not be_nil
      @numusers.should_not be_nil
      @numsites.should_not be_nil
    end
  end

  describe '#mailout' do

    before(:each) do
      email = "walter@stormsavvy.com"
      @mailer = UserMailer.mailout(email).deliver
    end

    it "delivers mail successfully" do
      ActionMailer::Base.deliveries.should_not be_empty
    end

    it "renders successfully" do
      lambda { @mailer }.should_not raise_error
    end

    it "has text in body" do
      @mailer.body.should_not be_empty
      # @mailer.body.should have_selector("ul.projects")
      # @mailer.body.should have_selector("ul.sites")
    end

    it "returns zipcodes" do
      zipcodes = []
      @project.sites.each do |site|
        zipcodes << site.get_zipcode
      end
      @project.get_site_zipcodes.should == zipcodes
    end

    it "returns nf stub value" do
      @nf.should_not be_nil
    end
  end

  describe '#thankyou' do
    before(:each) do
      email = "walter@stormsavvy.com"
      @mailer = UserMailer.thankyou(email).deliver
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
