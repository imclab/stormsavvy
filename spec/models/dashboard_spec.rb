require 'spec_helper'

describe Dashboard do

  it "creates a valid model" do
    db = Dashboard.create!
    db.should be_valid
  end
end
