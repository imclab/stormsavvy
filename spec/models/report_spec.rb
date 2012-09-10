require 'spec_helper'

describe Report do

  before(:each) do 
    @reports1 = [@r1, @r2]
    @reports2 = [@r3, @r4]

    [@r1, @r2].each do |r|
      FactoryGirl.create(:report)
    end

    [@r3, @r4].each do |r|
      FactoryGirl.create(:report)
    end
  end

  # Testing framework count methods
  context 'counting' do 

    it "should increase report count by 1" do
      expect { Report.create }.to change(Report, :count).by(+1)
    end
  end

  context 'CRUD operations' do
    it "should insert 4 reports" do
      @reports2.insert(2, @r3, @r4)
      @reports2.count.should == 4

      @reports2.push(@r3, @r4)
      @reports2.count.should == 6
    end

    it "should delete added report" do
      precount = @reports1.count
      @reports1.delete_at(1)
      @reports1.count.should == precount - 1
    end

    it "should find report by id" do
      @r1 = Report.find(1)

      # Print and verify @r1.id
      number_id = print(@r1.id)
      print "#{number_id}\n"

      @r6 = Report.create

      # Print and verify @r6.id
      report_number_id = print(@r6.id)
      print "#{report_number_id}\n"

      # Print and verify @r6.object_id
      report_object_id = print(@r6.object_id)
      print "#{report_object_id}\n"
    end

    it "should not insert invalid reports" do
      r = Report.new
      r.should be_valid

      @r5 = Report.create
      expect { @reports2 << @r5 }.to change(Report, :count).by(0)
    end
  end

  context 'status' do
    it "should change status on update" do
      r = Report.create
      r.status.should be_nil
      r.contractor_name = "Ghilotti Bros"
      r.save
      r.status.should == "completed"
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
