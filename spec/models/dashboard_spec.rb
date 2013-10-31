require 'spec_helper'

describe Dashboard do

  it "creates a valid model" do
    Dashboard.create!.should be_valid
  end
end
