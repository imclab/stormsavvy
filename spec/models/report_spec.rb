require 'spec_helper'

describe Report do

  it "should create a valid report" do
    r = Report.new
    r.should be_valid
  end

  it "should respond to sites" do
    r = Report.new
    r.should respond_to(:site)
  end

  it "should change status on update" do
    r = Report.create
    r.status.should be_nil
    r.contractor_name = "Ghilotti Bros"
    r.save
    r.status.should == "completed"
  end

  context :report do 

    before(:each) do 
      @report = Factory(:report)
      @report2 = Report.new
    end

    it "should be able to add 1 site" do
      @project.site.reports.count.should == 1
    end

    it "should not able to add invalid reports" do
      @project.site.reports << Report.new
      @project.site.reports.count.should == 1
    end

    # it "should be able to add multiple sites" do
    #   @project.sites << @site2
    #   @site2.save
    #   @project.sites.count.should be > 1
    # end
    
    # it "should be able to delete an added site" do
    #   precount = @project.sites.count
    #   @project.sites << @site2
    #   @project.sites.delete
    #   @project.sites.count.should == precount
    # end
  end

  context 'scopes' do
    it "should ony return reports needing attention" do
      Report.needs_attention.where_values_hash.should == 
        {:status => "needs_attention"}
    end

    it "should ony return completed reports" do
      Report.completed.where_values_hash.should == 
        {:status => "completed"}
    end
  end
end