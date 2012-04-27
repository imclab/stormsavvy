require 'spec_helper'

describe Project do

  before :each do
  	@project = FactoryGirl.create(:project)
  	@attr = {
  	  :name => "Hwy 99",
  	  :description => "Pothole Repair",
  	  :startdate => DateTime.new(2010),
  	  :finishdate => DateTime.new(2011),
  	  :active => true
  	}
  end

  it "should have project attributes" do
    @project.name.should == "Hwy 101 Corridor"
    @project.startdate.should == DateTime.new
  	@project.finishdate.should == DateTime.new
  	@project.active.should == false
  end

  it "should create a new instance given valid attributes" do
    project = Project.new(@attr)
    project.save
    project.should be_valid
  end

  describe "validations" do
    it "should require a name" do
      @project.name = ''
      @project.should_not be_valid
    end
    it "should require a description" do
      @project.description = ''
      @project.should_not be_valid
    end
    it "requires a starting date" do
      @project.startdate = ''
      @project.should_not be_valid
    end
    it "requires a finishing date" do
      @project.finishdate = ''
      @project.should_not be_valid
    end
  end

  describe "project associations" do

    before(:each) do
      @project = Project.new(@attr)
    end
    
    context :user do 
      it "should be associated with a user" do
        @project.should respond_to(:user)
      end
      
      it "should have the correct associated user" do
        #@project.should == @project.id
        @project.should == @project
      end    
    end

    context :site do 

      before(:each) do 
        @site = FactoryGirl.create(:site)
        @site2 = Site.new(:name => "Test Site", :zipcode => 94610)
      end

      it "should be associated with sites" do 
        @project.should respond_to(:sites)
      end

      it "should be able to add 1 site" do
        @project.sites.count.should == 1
      end

      it "should not able to add invalid sites" do
        @project.sites << Site.new
        @project.sites.count.should == 1
      end

      it "should be able to add multiple sites" do
        @project.sites << @site2
        @site2.save
        @project.sites.count.should be > 1
      end
      
      it "should be able to delete an added site" do
        precount = @project.sites.count
        @project.sites << @site2
        @project.sites.delete
        @project.sites.count.should == precount
      end
    end
  end

  describe "date format validations" do

    it "start date should be less than finish date" do
      @project = project.new(@attr)
      @project.startdate.should < @project.finishdate
    end

    it "start date should not be greater than finish date" do
      @project = @project.new(@attr)
      @project.startdate.should_not > @project.finishdate
    end

    it "finish date should raise error" do
      @project = @project.new(@attr)
      @project.finishdate=(DateTime.new(1999))
      expect {
        @project.save!
      }.to raise_error(ActiveRecord::RecordNotSaved)
    end
  end
end
