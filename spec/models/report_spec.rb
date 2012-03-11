require 'spec_helper'

describe Report do

  it "should create a valid report" do
    r = Report.new
    r.should be_valid
  end

  it "should change status on update" do
    r = Report.create
    r.status.should be_nil
    r.contractor_name = "Ghilotti Bros"
    r.save
    r.status.should == "complete"
  end
end
