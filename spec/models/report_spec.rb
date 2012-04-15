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