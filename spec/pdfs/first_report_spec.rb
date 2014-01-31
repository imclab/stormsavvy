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

  it "returns image info object" do
    info =  @pdf.image(filename)
    info.should be_a_kind_of(Prawn::Images::PNG)
    info.width.should == 600
    info.height.should == 776
  end

  it 'analyzes pdf with background image' do
    # img = "#{Prawn::DATADIR}/images/letterhead.jpg"
    # pdf = Prawn::Document.generate(
    #   "background.gif",
    #   background: img,
    #   margin: 100
    # ) do
    #   text "stormsavvy", size: 12, align: :right
    # end
    rendered_pdf = pdf.render
    text_analysis = PDF::Inspector::Text.analyze(rendered_pdf)
    pp text_analysis.methods
    # text_analysis.strings.should include("foo")
    # pdf.should be_a_kind_of(Prawn::Images::PDF)
  end

  it 'creates pdf with background image' do
    pdf = Prawn::Document.new(
      :background => "#{Prawn::BASEDIR}/data/images/reports/CEM2030-2012_Page_01.png"
    ) do
      text "stormsavvy", size: 12, align: :right
    end
    pdf.render_file "example.pdf"
  end
end
