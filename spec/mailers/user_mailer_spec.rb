require "spec_helper"

# http://robaldred.co.uk/2009/12/testing-actionmailer-models-with-rspec/
# http://stackoverflow.com/questions/5843284/clearing-out-activemailerbase-deliveries-after-rspec-test
describe UserMailer do

  before { ActionMailer::Base.deliveries = [] }

  it "should send Pop Alert emails" do
    user = FactoryGirl.create(:user)
    UserMailer.pop_alert(user).deliver
    ActionMailer::Base.deliveries.should_not be_empty
  end

  it "should send Pop emails" do
    user = FactoryGirl.create(:user)
    UserMailer.pop.deliver
    ActionMailer::Base.deliveries.should_not be_empty
  end


  it "should send something via mailout" do   
    user = FactoryGirl.create(:user)
    project = user.projects.create!(:name => 'foo', :description => 'bar', :startdate => 3.days.ago, :finishdate => 1.day.ago)
    site = project.sites.create!(:name => "Oakland Adams Point", :zipcode => 94610)
    # Note that the site is not associated with the user, only the project.
    # Lots of intricate associations coming.
    #p user.sites.first
    UserMailer.mailout
    ActionMailer::Base.deliveries.should_not be_empty
  end

  describe "mailout" do

    before(:each) do
      user = FactoryGirl.create(:user)
      project = user.projects.create!(:name => 'foo', :description => 'bar', :startdate => 3.days.ago, :finishdate => 1.day.ago)
      site = project.sites.create!(:name => "Oakland Adams Point", :zipcode => 94610)
    end

    it "should render successfully" do
      lambda { UserMailer.mailout  }.should_not raise_error
    end

    describe "rendered without error" do

      before(:each) do
        @mailer = UserMailer.mailout
      end

      it "it should have an alert" do
        @mailer.body.should have_css('.chance-of-rain', :text => 'chance of rain')
      end

      it "should have a list of projects" do
        @mailer.body.should have_selector("ul.projects")
      end

      it "should have a list of sites" do
        @mailer.body.should have_selector("ul.sites")
      end
    end
  end

end
