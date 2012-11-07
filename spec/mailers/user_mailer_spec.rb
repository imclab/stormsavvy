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
    # @p1 = FactoryGirl.create(
    #   :project, 
    #   :user => @user, 
    #   :created_at => 1.day.ago
    #   )
    # @p2 = FactoryGirl.create(
    #   :project, 
    #   :user => @user, 
    #   :created_at => 1.hour.ago
    #   )
    # @projects = [@p1, @p2]
    
    # @s1 = FactoryGirl.create(
    #   :site, 
    #   :project => @p1, 
    #   :name => 'ec jungle gym', 
    #   :zipcode => 94530
    #   )
    # @s2 = FactoryGirl.create(
    #   :site, 
    #   :project => @p2, 
    #   :name => 'ec playground slide', 
    #   :zipcode => 94530
    #   )
    # @sites = [@s1, @s2]

    # Build using new and save methods
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
      lambda { @mailer }.should_not raise_error
    end

    it "should have list of projects, site and POP" do
      @mailer.body.should have_selector("ul.projects")
      @mailer.body.should have_selector("ul.sites")
      @mailer.body.should have_selector('.chance-of-rain', :text => 'chance of rain')
    end
  end
end
