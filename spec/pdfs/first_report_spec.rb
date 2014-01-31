require 'spec_helper'
require 'set'
require 'pathname'
require 'prawn'
require 'pdf/reader'
require 'pdf/inspector'

describe FirstReport do

  let(:report) { FactoryGirl.create(:report) }
  let(:filename) { "#{Prawn::DATADIR}/images/reports/CEM2030-2012_Page_01.png" }
  let(:content) { "stormsavvy" }
  let(:pdf) { Prawn::Document.generate "example.pdf" do |pdf|
      pdf.font "Times-Roman"
      pdf.draw_text content, at: [200,720], size: 32
      pdf.background filename
    end
  }

  before(:each) do
    create_pdf
  end

  it "embeds only image once, even if added multiple times" do
    @pdf.image filename, :at => [100,100]
    @pdf.image filename, :at => [300,300]

    output = @pdf.render
    images = PDF::Inspector::XObject.analyze(output)
    images.page_xobjects.first.size.should == 2
    output.scan(/Type \/XObject/).size.should == 1
  end

  it "should return the image info object" do
    info =  @pdf.image(filename)
    info.should be_a_kind_of(Prawn::Images::PNG)
    info.width.should == 600
    info.height.should == 776
  end

  it 'creates first report' do
    # filename = "#{Prawn::DATADIR}/images/reports/CEM2030_production_v1.pdf"
    # pdf = FirstReport.new(
    #   @report,
    #   view_context,
    #   background: "#{Prawn::DATADIR}/images/reports/CEM2031-2012_Page_01.png",
    #   template: filename
    # )
  end
end
