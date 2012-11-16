require 'spec_helper'

require 'set'
require 'pathname'

describe FirstReport do

  before(:each) do
    @report = FactoryGirl.create(:report)
    @filename = "#{Prawn::DATADIR}/images/reports/CEM2030-2012_Page_01.png"
    @img_data = File.open(@filename, "rb") { |f| f.read }
    create_pdf
  end

  xit "should read the basic attributes correctly" do
    print Prawn::Images::JPG.methods

    @jpg = Prawn::Images::JPG.new(@img_data)
    jpg.should be_valid
    # jpg.width.should == 604
    # jpg.height.should == 453
    # jpg.bits.should == 8
    # jpg.channels.should == 3
  end

  it "should only embed an image once, even if it's added multiple times" do
    @pdf.image @filename, :at => [100,100]
    @pdf.image @filename, :at => [300,300]

    output = @pdf.render
    images = PDF::Inspector::XObject.analyze(output)
    images.page_xobjects.first.size.should == 2
    output.scan(/Type \/XObject/).size.should == 1
  end

  xit "should return the image info object" do
    info =  @pdf.image(@filename)
    info.should.be.kind_of(Prawn::Images::JPG)
    info.height.should == 453
  end
end
