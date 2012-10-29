require "spec_helper"

describe UserMailer do

  before { ActionMailer::Base.deliveries = [] }

  before(:each) do

    # @user = User.create!(
    #   :firstname              => 'Walter',
    #   :lastname               => 'Yu',
    #   :email                  => 'walter@stormsavvy.com',
    #   :password               => 'DarkAndStormy',
    #   :password_confirmation  => 'DarkAndStormy'
    #   )
    # @project = Project.create!(
    #   :user_id                => 1,
    #   :name                   => "EC Park & Rec",
    #   :description            => "Jungle Gym, etc.",
    #   :startdate              => DateTime.new,
    #   :finishdate             => DateTime.new,
    #   :active                 => false
    #   )
    # @site = Site.create!(
    #   :name                   => "EC Jungle Gym",
    #   :description            => "New Playground",
    #   :costcode               => "450AZC",
    #   :size                   => "20 acres",
    #   :exposed_area           => "10 acres",
    #   :zipcode                => 94610
    #   )

    # TODO: Debug spec factory tables
    @user = FactoryGirl.create(:user)
    @p1 = FactoryGirl.create(:project, :user => @user, :created_at => 1.day.ago)
    @p2 = FactoryGirl.create(:project, :user => @user, :created_at => 1.hour.ago)
    @projects = [ @p1, @p2]
    # @project = FactoryGirl.create(:project)
    @site = FactoryGirl.create(:site)
  end

  describe "mailout mailer" do

    # TODO: Debug project factory table
    before(:each) do
      @receipient = "walter@stormsavvy.com"
      @mailer = UserMailer.mailout(@recipient).deliver
    end

    it "should send something via mailout" do
      ActionMailer::Base.deliveries.should_not be_empty
    end

    it "should render successfully" do
      lambda { UserMailer.mailout.deliver }.should_not raise_error
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
