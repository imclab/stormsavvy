require 'spec_helper'
require 'project_local_time'

describe ProjectLocalTime do
=begin
  before :each do
    time = Time.new(2013, 01, 13, 18, 0, 0)
    @local_time = ProjectLocalTime::format(time)
  end
=end
  it "formats date, time and time zone" do
    datetime = "Sunday, 13 January 2013 18:00 PST"
    time = Time.new(2013, 01, 13, 18, 0, 0)
    # @local_time = ProjectLocalTime::format(time)

    ProjectLocalTime::format(time).should == datetime
    # @local_time.should == datetime
  end

  it "formats date" do
    datetime = "Sunday, 19 January 2014"
    time = Time.new(2014, 01, 19)
    # @local_time = ProjectLocalTime::format(time)

    ProjectLocalTime::date_only(time).should == datetime
    # @local_time.should == datetime
  end
end
