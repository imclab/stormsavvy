require 'spec_helper'

describe SitePop do

  it "creates its ownself" do
    sp = SitePop.create!
    sp.class.should == SitePop
  end
end
