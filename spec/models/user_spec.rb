require 'spec_helper'

describe User do
  
  it "should create a valid user" do
    @user = User.create(
      :email => 'foo@bar.com', 
      :password => 'foobarbaz',
      :password_confirmation => 'foobarbaz'
      )
    @user.should be_valid
  end

  describe "site associations" do

    before(:each) do
      @user = FactoryGirl.create(:user)
      @p1 = FactoryGirl.create(:project, :user => @user, :created_at => 1.day.ago)
      @p2 = FactoryGirl.create(:project, :user => @user, :created_at => 1.hour.ago)
    end

    it "should respond to projects" do
      @user.should respond_to(:projects)
    end

    it "should have the right projects in the right order" do
      @user.projects.should == [@p1, @p2]
    end

    it "should destroy associated sites" do
      @user.destroy
      [@p1, @p2].each do |p|
        Project.find_by_id(p.id).should be_nil
      end
    end

    # it "should enforce unique email" do
    #   m1 = Factory(:user)
    #   m2 = Factory.build(:user, :email => m1.email).should_not be_valid
    # end
  end

  context :has_site do

    before(:each) do 
      @user = User.create(
        :email => 'foo@bar.com', 
        :password => 'foobarbaz',
        :password_confirmation => 'foobarbaz'
        )

      # TODO: Resolve duplicate user factory table error.
      # @user = FactoryGirl.create(:user)
    end

    it "should respond to has_site?" do
      @user.should respond_to(:has_site?)
    end

    it "should reply appropriately if user has a site" do
      project = FactoryGirl.create(:project)
      site = FactoryGirl.create(:site)
      project.sites << site
      assert_equal @user.has_site?, true
    end

    it "should reply appropriately if user does not have site" do
      project = FactoryGirl.create(:project)
      site = FactoryGirl.create(:site)
      assert_equal @user.has_site?, false
    end

  end

end
