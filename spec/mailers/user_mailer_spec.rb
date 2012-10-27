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
    @project = Project.create!(
      :user_id                => 1,
      :name                   => "EC Park & Rec",
      :description            => "Jungle Gym, etc.",
      :startdate              => DateTime.new,
      :finishdate             => DateTime.new,
      :active                 => false
      )
    @site = Site.create!(
      :name                   => "EC Jungle Gym",
      :description            => "New Playground",
      :costcode               => "450AZC",
      :size                   => "20 acres",
      :exposed_area           => "10 acres",
      :zipcode                => 94610
      )

    # TODO: Debug spec factory tables
    # @user = FactoryGirl.create(:user)
    # @project = FactoryGirl.create(:project)
    # @site = FactoryGirl.create(:site)
  end

  describe "mailout mailer" do

    # TODO: Debug project factory table
    before(:each) do
      @mailer = UserMailer.mailout.deliver
    end

    xit "should send something via mailout" do
      ActionMailer::Base.deliveries.should_not be_empty
    end

    xit "should render successfully" do
      lambda { UserMailer.mailout(@email).deliver }.should_not raise_error
    end

    xit "it should have an alert" do
      @mailer.body.should have_css('.chance-of-rain', :text => 'chance of rain')
    end

    xit "should have a list of projects" do
      @mailer.body.should have_selector("ul.projects")
    end

    xit "should have a list of sites" do
      @mailer.body.should have_selector("ul.sites")
    end
  end

end
