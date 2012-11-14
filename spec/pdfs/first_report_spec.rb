require 'spec_helper'

describe FirstReport do

  before(:each) do
    @report = FactoryGirl.create(:report)
    @filename1 = "#{Prawn::DATADIR}/images/reports/CEM2030-2012_Page_01.png"
    @img_data = File.open(@filename1, "rb") { |f| f.read }
  end

  describe :build_report do
  	it "builds all pages of pdf" do
      create_pdf
    end
  end
   
  it "should read the basic attributes correctly" do
    jpg = Prawn::Images::JPG.new(@img_data)
    
    jpg.should be_valid
    # jpg.width.should == 604
    # jpg.height.should == 453
    # jpg.bits.should == 8
    # jpg.channels.should == 3
  end
end