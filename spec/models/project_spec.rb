require 'spec_helper'

describe Project do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project) }
  let!(:project1) { FactoryGirl.create(
    :project, user: user, created_at: 1.day.ago
    )
  }
  let!(:project2) { FactoryGirl.create(
    :project, user: user, created_at: 1.hour.ago
    )
  }
  let!(:projects) { [project1, project2] }

  let!(:site1) { FactoryGirl.create(
    :site, user: user, name: 'ec jungle gym', zipcode: 94530
    )
  }
  let!(:site2) { FactoryGirl.create(
    :site, user: user, name: 'ec playground slide', zipcode: 94530
    )
  }
  let!(:sites) { [site1, site2] }

  describe 'saving before validation' do
    it "creates new instance given valid attributes" do
      project = Project.new(name: 'ecp', description: 'plaza work')
      project.save
      project.should be_valid
    end
  end

  describe "validations" do
    it "should require a name" do
      project.name = ''
      project.should_not be_valid
    end

    it "should require a description" do
      project.description = ''
      project.should_not be_valid
    end

    it "requires a starting date" do
      project.startdate = ''
      project.should be_valid
    end

    it "requires a finishing date" do
      project.finishdate = ''
      project.should be_valid
    end

    it "has correct project attributes" do
      # @project.name.should == "Hwy 101 Corridor"
      project.startdate.should == DateTime.new(2011)
      project.finishdate.should == DateTime.new(2012)
      project.active.should == false
    end
  end

  describe "project associations" do
    context :user do
      it "should be associated with a user" do
        project.should respond_to(:user)
      end

      it "should have the correct associated user" do
        project.should == project
      end
    end

    context :site do
      it "should be associated with sites" do
        project.should respond_to(:sites)
      end

      it "should be able to add 1 site" do
        pending 'site/project association removed'
        lambda{
          FactoryGirl.create(:site, project: project)
        }.should change(project.sites, :count).by(1)
      end

      it "should not able to add invalid sites" do
        lambda{
          project.sites << Site.new
        }.should change(project.sites, :count).by(0)
      end

      it "should be able to add multiple sites" do
        lambda{
          project.sites << site1
          site1.save
        }.should change(project.sites, :count).by(1)
      end

      it "should be able to delete an added site" do
        precount = project.sites_count
        project.sites << site1
        site1.save
        site1.delete
        project.sites_count.should == precount
      end
    end
  end

  describe "date format validations" do
    it "start date should be less than finish date" do
      project.startdate.should < project.finishdate
    end

    it "start date should not be greater than finish date" do
      project.startdate.should_not > project.finishdate
    end

    it "finish date should raise error" do
      pending 'finish date logic needs work'
      @project = Project.new(@attr)
      @project.finishdate=(DateTime.new(1999))
      expect {
      @project.save!
      }.to raise_error(ActiveRecord::RecordNotSaved)
    end
  end

  describe '#get_site_zipcodes' do
    it 'returns array of site zipcodes' do
      zipcodes = []
      project.sites.each do |site|
        zipcodes << site.zipcode
      end
      project.get_site_zipcodes.should == zipcodes
    end
  end
end
