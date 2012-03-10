require 'spec_helper'

describe Project do

  before :each do
  	@project = Factory(:project)
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
    
    it "should be associated with a user" do
      @project.should respond_to(:user)
    end
    
    it "should have the correct associated user" do
      #@project.should == @project.id
      @project.should == @project
    end    
  end

  describe "date format validations" do

    it "start date should be less than finish date" do
      @project = Project.create(@attr)
      @project.startdate.should < @project.finishdate
    end

    it "start date should not be greater than finish date" do
      @project = Project.create(@attr)
      @project.startdate.should_not > @project.finishdate
    end

    it "finish date should raise error" do
      @project = Project.create(@attr)
      @project.finishdate=(DateTime.new(1999))
      expect {
        @project.save!
      }.to raise_error(ActiveRecord::RecordNotSaved)
    end
  end
end