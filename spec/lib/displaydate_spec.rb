require 'spec_helper'
require_relative '../../lib/displaydate'

describe Time do

  let(:time) { Time.at(1351404000) }

  # before(:all) do
  #   @t = Time.at(1351404000)
  # end

  it "shows that it's Saturday today" do
    day = time.strftime("%A")
    day.should == "Saturday"
  end

  it "shows that the month is October" do
    month = time.strftime("%B")
    month.should == "October"
  end

  it "shows the date as the 27th" do
    date = time.strftime("%d")
    date.should == "27"
  end

  it "shows the year as 2012" do
    year = time.strftime("%Y")
    year.should == "2012"
  end

end

describe DisplayDate do

  before(:all) do
    @epoch = 1351404000
  end

  before(:each) do
    @dd = DisplayDate.new
    @dd.set_epoch(@epoch)
  end

  it "should display the day as Saturday" do
    day = @dd.get_day("day")
    day.should =~ /Saturday/
  end

  it "should display the  month as Oct" do
    month = @dd.get_month("month")
    month.should =~ /Oct/
  end

end
