require 'spec_helper'

describe User do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @project1 = FactoryGirl.create(
      :project,
      :user => @user,
      :created_at => 1.day.ago
      )
    @projects = [@project1]
    # @project2 = FactoryGirl.create(
    #   :project,
    #   :user => @user,
    #   :created_at => 1.hour.ago
    #   )
    # @projects = [@project1, @project2]

    @site1 = FactoryGirl.create(
      :site,
      :project => @project1,
      :name => 'ec jungle gym',
      :zipcode => 94530
      )
    @sites = [@site1]
    # @site2 = FactoryGirl.create(
    #   :site,
    #   :project => @project2,
    #   :name => 'ec playground slide',
    #   :zipcode => 94530
    #   )
    # @sites = [@site1, @site2]
  end

  it "should create a valid user" do
    user = User.create(
      :email =>     'foo@bar.com',
      :password =>  'foobarbaz'
      )
    @user.should be_valid
  end

  describe "project associations" do

    it "should respond to projects" do
      @user.should respond_to(:projects)
    end

    it "has projects in correct order" do
      @user.projects.should == @projects
    end

    it "destroys associated sites" do
      @user.destroy
      @projects.each do |p|
        Project.find_by_id(p.id).should be_nil
      end
    end

    it "enforces unique email" do
      # m1 = Factory(:user)
      # m2 = Factory.build(:user, :email => m1.email).should_not be_valid
      @user2 = FactoryGirl.build(
        :user,
        :email => @user.email
        ).should_not be_valid
    end
  end

  context :has_site? do
    it "should respond and reply appropriately if user has_site?" do
      @user.should respond_to(:has_site?)
      assert_equal @user.has_site?, true
    end

    it "should reply appropriately if user does not have site" do
      user = User.create(
        :email =>     'foo@bar.com',
        :password =>  'foobarbaz'
        )
      assert_equal user.has_site?, false
    end
  end

  describe '#get_user_zipcodes' do
    it 'returns array of user site zipcodes' do
      # sites = [@site1, @site2]

      zipcodes = []

      @projects.each do |project|
        project.sites.each do |site|
          zipcodes << site.zipcode
        end
      end

      @user.get_site_zipcodes.should == zipcodes
    end
  end
end
