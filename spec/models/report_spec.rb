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
      [@r1, @r2].each do |r|
        FactoryGirl.create(:report)
      end

      @reports = [@r1, @r2]
    end

    it "should add 3 reports" do
      FactoryGirl.create(:report)
      FactoryGirl.create(:report)
      FactoryGirl.create(:report)
      Report.count.should == 5
    end

    it "should work with insert method" do
      [@r3, @r4].each do |r|
        FactoryGirl.create(:report)
      end

      @reports.insert(2, @r3, @r4)
      @reports.count.should == 4
    end

    it "should be able to add 1 report" do
      expect { Report.create }.to change(Report, :count).by(+1)
    end

    it "should not able to add invalid reports" do
      @r3 = Report.create
      expect { @reports << @r3 }.to change(Report, :count).by(0)
    end

    it "should be able to add multiple reports" do
      [@r3, @r4].each do |r|
        FactoryGirl.create(:report)
      end
      
      @reports.push(@r3, @r4)
      @reports.count.should == 4
    end
    
    it "should be able to delete an added site" do
      precount = @reports.count
      @reports.delete_at(1)
      @reports.count.should == precount - 1
    end
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
