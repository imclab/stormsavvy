require 'spec_helper'
require 'set'
require 'pathname'
require 'prawn'
require 'pdf/reader'
require 'pdf/inspector'

describe FirstReport do

  let(:filename) { "#{Prawn::DATADIR}/images/reports/CEM2030-2012_Page_01.png" }
  let(:content) { "stormsavvy" }

  before(:each) do
    create_pdf
  end

  describe 'pdf images' do
    it "returns image info object" do
      info =  @pdf.image(filename)
      info.should be_a_kind_of(Prawn::Images::PNG)
      info.width.should == 600
      info.height.should == 776
    end
  end

  describe 'pdf render and background' do
    it 'generates pdf, font and sizing' do
      let(:pdf) { Prawn::Document.generate "#{Rails.root}/app/assets/pdfs/example.pdf" do |pdf|
          pdf.font "Times-Roman"
          pdf.draw_text content, at: [200,720], size: 32
        end
      }
    end

    it 'creates pdf with background image' do
      background_pdf = Prawn::Document.new(
        :background => "#{Prawn::BASEDIR}/data/images/reports/CEM2030-2012_Page_01.png"
      ) do
        text "stormsavvy", size: 12, align: :right
      end
      background_pdf.render_file "#{Rails.root}/app/assets/pdfs/background.pdf"
    end

    it 'analyzes pdf with background image' do
      pdf = Prawn::Document.generate(
        "background.png",
        background: filename,
        margin: 100
      ) do
        text "stormsavvy", size: 12, align: :right
      end

      # pdf.render_file "#{Rails.root}/app/assets/pdfs/testem.pdf"
      # rendered_pdf = pdf.render
      # text_analysis = PDF::Inspector::Text.analyze('stormsavvy.pdf')
      # text_analysis = PDF::Inspector::Text.analyze(pdf)
      # text_analysis.strings.should include("stormsavvy")

      # pdf.should be_a_kind_of(Prawn::Images::PNG)
    end
  end

  describe 'verifying pdfs' do
    let(:pdf) { Prawn::Document.new }

    it 'verfies pdf using inspector' do
      pdf.text 'stormsavvy'
      result = PDF::Inspector::Page.analyze(pdf.render)
      result.pages.size.should === 1

      pdf.render_file 'stormsavvy.pdf'
    end
  end

  describe 'paging pdfs' do
    it 'generates 2 pages by adding 100 lines' do
      pdf = Prawn::Document.new
      100.times {pdf.text "stormsavvy"}
      result = PDF::Inspector::Page.analyze(pdf.render)
      result.pages.size.should === 2
      result.pages.size.should === pdf.page_count
    end

    it 'inspects page numbers' do
      pdf = Prawn::Document.new(:page_size => "A4", :page_layout => :portrait)
      100.times {pdf.text "stormpop who?"}
      pdf.number_pages("<page> of <total>", {
        :start_count_at => 1,
        :page_filter => lambda{ |pg| pg > 0 },
        :at => [pdf.bounds.right - 50, 0],
        :align => :right,
        :size => 9
      })
      result = PDF::Inspector::Page.analyze(pdf.render)
      result.pages.first[:strings].last.should === "1 of 2"
    end
  end
end
