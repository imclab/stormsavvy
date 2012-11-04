require 'spec_helper'

describe User do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @p1 = FactoryGirl.create(
      :project, 
      :user => @user, 
      :created_at => 1.day.ago
      )
    @p2 = FactoryGirl.create(
      :project, 
      :user => @user, 
      :created_at => 1.hour.ago
      )
    @projects = [@p1, @p2]
    
    @s1 = FactoryGirl.create(
      :site, 
      :project => @p1, 
      :name => 'ec jungle gym', 
      :zipcode => 94530
      )
    @s2 = FactoryGirl.create(
      :site, 
      :project => @p2, 
      :name => 'ec playground slide', 
      :zipcode => 94530
      )
    @sites = [@s1, @s2]

  end

  it "should create a valid user" do
    user = User.create(
      :email =>     'foo@bar.com',
      :password =>  'foobarbaz'
      )
    @user.should be_valid
  end

  describe "site associations" do

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

    xit "should enforce unique email" do
      m1 = Factory(:user)
      m2 = Factory.build(:user, :email => m1.email).should_not be_valid
    end
  end

  context :has_site do

    it "should respond to has_site?" do
      @user.projects.build
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

  context :list_sites do

    it "returns list of user sites" do
      @user.should respond_to(:list_sites)
    end

  end

end
