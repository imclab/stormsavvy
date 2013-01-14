require 'spec_helper'
require 'project_localtime'

describe ProjectLocalTime do

  it "instantiates class object" do
    pt = ProjectLocalTime.new
    pt.class.should == ProjectLocalTime
  end

end
