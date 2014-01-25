require 'spec_helper'
require 'pdf-reader'

describe ReportsPdf do
  let(:user) { FactoryGirl.build(:user) }
  let(:reviews) { FactoryGirl.build(:report) }
  let(:pdf) { described_class.new(user, report) }

  let(:report) { ReportsPdf.new }
  # let(:report) { double(ReportsPdf) }

  let(:filename) { "#{Prawn::DATADIR}/images/arrow.jpg" }
  let(:cem) { "#{Prawn::DATADIR}/images/reports/CEM2031-2012_Page_01.png" }

  before(:each) do
    create_pdf
  end

  it 'renders pdf correctly' do
    # pdf-reader gem for spec
    # reader = PDF::Reader.new(StringIO.new(pdf.build))
    # page = Capybara.string(reader.pages.collect(&:text).join("\n"))
    # page.should have_content('text')
  end

  describe '#page_background' do
    it 'places background image' do
      report.should respond_to(:page_background)

      # save background image for later
      # pp report.page_background(filename)
    end

    it "returns default image info object" do
      # save background image for later
      # info =  @pdf.image(filename)
      # info.should be_a_kind_of(Prawn::Images::JPG)
      # info.height.should == 453
    end

    it "returns default image info object" do
      # save background image for later
      # info =  @pdf.image(cem)
      # info.should be_a_kind_of(Prawn::Images::PDF)
      # info.height.should == 453
    end
  end

  describe '#testem_fields' do
    it 'places template image' do
      report.should respond_to(:testem_fields)

      # save background image for later
      # testem = report.testem_fields(cem)
      # pp report.page_background(filename)
    end
  end
end
