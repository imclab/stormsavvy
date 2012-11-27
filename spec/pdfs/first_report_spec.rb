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

  it "should only embed an image once, even if it's added multiple times" do
    @pdf.image @filename, :at => [100,100]
    @pdf.image @filename, :at => [300,300]

    output = @pdf.render
    images = PDF::Inspector::XObject.analyze(output)
    images.page_xobjects.first.size.should == 2
    output.scan(/Type \/XObject/).size.should == 1
  end
end
