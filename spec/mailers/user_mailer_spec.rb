require "spec_helper"

describe UserMailer do

  before { ActionMailer::Base.deliveries = [] }

  before(:each) do

    @user = User.create!(
      :firstname              => 'Walter',
      :lastname               => 'Yu',
      :email                  => 'walter@stormsavvy.com',
      :password               => 'DarkAndStormy',
      :password_confirmation  => 'DarkAndStormy'
      )
    @project = FactoryGirl.create(:project)
    @site = FactoryGirl.create(:site)
    # @site = @project.sites.create!(
    #   :name => "Oakland Adams Point",
    #   :zipcode => 94610
    #   )
  end

  describe "mailout mailer" do

    before(:each) do
      @mailer = UserMailer.mailout.deliver
    end

    it "should send something via mailout" do
      ActionMailer::Base.deliveries.should_not be_empty
    end

    it "should render successfully" do
      lambda { UserMailer.mailout }.should_not raise_error
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
