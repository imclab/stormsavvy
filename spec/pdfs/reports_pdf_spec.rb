require 'spec_helper'
require 'pdf-reader'

describe ReportsPdf do
  let(:user) { create(:user) }
  let(:reviews) { create(:reviews) }
  let(:pdf) { described_class.new(user, [reviews]) }

  let(:report) { ReportsPdf.new }
  # let(:report) { double(ReportsPdf) }
  let(:filename) { "#{Prawn::DATADIR}/images/pigs.jpg" }
  let(:cem) { "#{Prawn::DATADIR}/images/reports/CEM2031-2012_Page_01.png" }

  before(:each) do
    create_pdf
  end

  xit 'renders pdf correctly' do
    # pdf-reader gem for spec
    reader = PDF::Reader.new(StringIO.new(pdf.build))
    page = Capybara.string(reader.pages.collect(&:text).join("\n"))
    page.should have_content('text')
  end

  describe '#page_background' do
    it 'places background image' do
      report.should respond_to(:page_background)
      pp report.page_background(filename)
    end

    it "returns default image info object" do
      info =  @pdf.image(filename)
      info.should be_a_kind_of(Prawn::Images::JPG)
      info.height.should == 453
    end

    it "returns default image info object" do
      info =  @pdf.image(cem)
      pp info
      info.should be_a_kind_of(Prawn::Images::PNG)
      # info.height.should == 453
    end
  end
end
