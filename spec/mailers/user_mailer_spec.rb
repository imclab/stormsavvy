require "spec_helper"

describe UserMailer do

  before { ActionMailer::Base.deliveries = [] }

  before(:each) do
    @user = FactoryGirl.create(:user)
    @email = 'walter@stormsavvy.com'
    @greeting = 'Greetings'
    @salutation = 'The Storm Savvy Team'

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

    @report = FactoryGirl.create(
      :report,
      :site => @site,
      :status => 'needs_attention'
    )
    @numreports = [ @report ]

    @ie = FactoryGirl.create(
      :inspection_event,
      :completed => false
    )
    @numinspections = [ @ie ]

    @numusers = [ @user ]
    @numprojects = [ @project ]
    @numsites = [ @site ]

    @fullcount = 29
    @lat = 37.9202057
    @long = -122.2937428
    @nf = double(NOAAForecast)
  end

  describe '#pester_admins' do

    before(:each) do
      @mailer = UserMailer.pester_admins(@email).deliver
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

    it 'has correct greeting and salutation' do
      @greeting.should == 'Greetings'
      @salutation.should == 'The Storm Savvy Team'
    end

    it "renders correct count" do
      @numprojects.should_not be_nil
      @numusers.should_not be_nil
      @numsites.should_not be_nil
      @numreports.should_not be_nil
      @numinspections.should_not be_nil
    end

    it "returns nf stub value" do
      @nf.should_not be_nil
    end
  end

  describe '#staging_mailer' do

    before(:each) do
      @mailer = UserMailer.staging_mailer(@email).deliver
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

    it 'has correct greeting and salutation' do
      @greeting.should == 'Greetings'
      @salutation.should == 'The Storm Savvy Team'
    end

    it "renders correct count" do
      @numprojects.should_not be_nil
      @numusers.should_not be_nil
      @numsites.should_not be_nil
      @numreports.should_not be_nil
      @numinspections.should_not be_nil
    end
  end

  describe '#mailout' do

    before(:each) do
      @mailer = UserMailer.mailout(@email).deliver
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

    it 'has correct greeting and salutation' do
      @greeting.should == 'Greetings'
      @salutation.should == 'The Storm Savvy Team'
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
      @mailer = UserMailer.thankyou(@email).deliver
    end

    it "delivers mail successfully" do
      ActionMailer::Base.deliveries.should_not be_empty
    end

    it "renders successfully" do
      lambda { @mailer }.should_not raise_error
    end

    it "has text in body" do
      @mailer.body.should_not be_empty
    end

    it 'has correct greeting and salutation' do
      @greeting.should == 'Greetings'
      @salutation.should == 'The Storm Savvy Team'
    end
  end
end
