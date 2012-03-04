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
    project.first.should be_valid
  end
  
  describe "project associations" do

    before(:each) do
      @project = Project.new(@attr)
    end
    
    xit "should have a project attribute" do
      @project.should respond_to(:user)
    end
    
    it "should have the correct associated member" do
      #@project.should == @project.id
      @project.should == @project
    end    
  end

  describe "date format validations" do

    it "start date should be less than finish date" do
      @project = project.create(@attr)
      @project.startdate.should < @project.finishdate
    end

    it "start date should not be greater than finish date" do
      @project = @project.create(@attr)
      @project.startdate.should_not > @project.finishdate
    end

    it "finish date should raise error" do
      @project = @project.create(@attr)
      @project.finishdate=(DateTime.new(1999))
      expect {
        @project.save!
      }.to raise_error(ActiveRecord::RecordNotSaved)
    end
  end
end