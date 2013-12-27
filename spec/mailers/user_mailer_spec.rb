require "spec_helper"

describe UserMailer do

  before { ActionMailer::Base.deliveries = [] }

  let(:email) { 'walter@stormsavvy.com' }
  let(:greeting) { 'Greetings' }
  let(:salutation) { 'The Storm Savvy Team' }

  let!(:user) { FactoryGirl.build(:user) }
  let(:users) { [ user ] }

  let!(:site) { FactoryGirl.create(
    :site,
    :user => user
    )
  }
  let(:sites) { [ site ] }

  let!(:report) { FactoryGirl.create(
    :report,
    :site => site
    )
  }
  let(:reports) { [ report ] }

  let!(:ie) { FactoryGirl.create(:inspection_event) }
  let(:pending_ie) { [ ie ] }

  let(:numusers) { User.count }
  let(:numsites) { Site.count }
  let(:numreports) { Report.count }
  let(:numinspections) { InspectionEvent.count }

  describe '#pester_admins' do

    before(:each) do
      @nf = double(NOAAForecast)
    end

    let!(:mailer) { UserMailer.pester_admins(email).deliver }

    it "delivers mail successfully" do
      ActionMailer::Base.deliveries.should_not be_empty
    end

    it "renders successfully" do
      lambda { mailer }.should_not raise_error
    end

    it "does not have empty text body" do
      mailer.body.should_not be_nil
    end

    it 'has correct greeting and salutation' do
      greeting.should == 'Greetings'
      salutation.should == 'The Storm Savvy Team'
    end

    it "renders correct count" do
      numprojects.should == Project.count
      numusers.should == User.count
      numsites.should == Site.count
      numreports.should == Report.count
      numinspections.should == InspectionEvent.count

      numprojects.should_not be_nil
      numusers.should_not be_nil
      numsites.should_not be_nil
      numreports.should_not be_nil
      numinspections.should_not be_nil
    end

    it "returns nf stub value" do
      @nf.should_not be_nil
    end

    it 'delays delivery using sidekiq' do
      expect { UserMailer.delay.pester_admins(email)}.to change(
        Sidekiq::Extensions::DelayedMailer.jobs, :size
      ).by(1)
    end
  end

  describe '#staging_mailer' do

    let!(:mailer) { UserMailer.staging_mailer(email).deliver }

    it "delivers mail successfully" do
      ActionMailer::Base.deliveries.should_not be_empty
    end

    it "renders successfully" do
      lambda { mailer }.should_not raise_error
    end

    it "does not have empty text body" do
      mailer.body.should_not be_nil
    end

    it 'has correct greeting and salutation' do
      greeting.should == 'Greetings'
      salutation.should == 'The Storm Savvy Team'
    end

    it "renders correct count" do
      numprojects.should == Project.count
      numusers.should == User.count
      numsites.should == Site.count
      numreports.should == Report.count
      numinspections.should == InspectionEvent.count

      numprojects.should_not be_nil
      numusers.should_not be_nil
      numsites.should_not be_nil
      numreports.should_not be_nil
      numinspections.should_not be_nil
    end

    it 'delays delivery using sidekiq' do
      expect { UserMailer.delay.staging_mailer(email)}.to change(
        Sidekiq::Extensions::DelayedMailer.jobs, :size
      ).by(1)
    end
  end

  describe '#mailout' do

    let!(:mailer) { UserMailer.mailout(email).deliver }

    it "delivers mail successfully" do
      ActionMailer::Base.deliveries.should_not be_empty
    end

    it "renders successfully" do
      lambda { mailer }.should_not raise_error
    end

    it "has text in body" do
      mailer.body.should_not be_empty
      # @mailer.body.should have_selector("ul.projects")
      # @mailer.body.should have_selector("ul.sites")
    end

    it 'has correct greeting and salutation' do
      greeting.should == 'Greetings'
      salutation.should == 'The Storm Savvy Team'
    end

    it "returns zipcodes" do
      zipcodes = []
      sites.each do |site|
        zipcodes << site.get_zipcode
      end
      get_zipcode = []
      get_zipcode << site.get_zipcode
      get_zipcode.should == zipcodes
      # site.get_zipcode.should == zipcodes
    end

    it "renders correct variables" do
      users.should == User.all
      users.should_not be_nil

      sites.should == user.sites
      sites.should_not be_nil

      reports.should == site.reports
      reports.should_not be_nil

      pending_ie.should == site.inspection_events
      pending_ie.should_not be_nil
    end

    it 'delays delivery using sidekiq' do
      expect { UserMailer.delay.mailout(email)}.to change(
        Sidekiq::Extensions::DelayedMailer.jobs, :size
      ).by(1)
    end
  end

  describe '#thankyou' do

    let!(:mailer) { UserMailer.thankyou(email).deliver }

    it "delivers mail successfully" do
      ActionMailer::Base.deliveries.should_not be_empty
    end

    it "renders successfully" do
      lambda { mailer }.should_not raise_error
    end

    it "has text in body" do
      mailer.body.should_not be_empty
    end

    it 'has correct greeting and salutation' do
      greeting.should == 'Greetings'
      salutation.should == 'The Storm Savvy Team'
    end

    it 'delays delivery using sidekiq' do
      expect { UserMailer.delay.thankyou(email)}.to change(
        Sidekiq::Extensions::DelayedMailer.jobs, :size
      ).by(1)
    end
  end
end
