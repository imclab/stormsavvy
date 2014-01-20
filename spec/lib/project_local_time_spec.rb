require 'spec_helper'
require 'project_local_time'

describe ProjectLocalTime do
  it "formats date, time and time zone" do
    datetime = "Sunday, 13 January 2013 18:00 PST"
    time = Time.new(2013, 01, 13, 18, 0, 0)
    ProjectLocalTime::format(time).should == datetime
  end

  it "formats date" do
    datetime = "Sunday, 19 January 2014"
    time = Time.new(2014, 01, 19)
    ProjectLocalTime::date_only(time).should == datetime
  end
end
