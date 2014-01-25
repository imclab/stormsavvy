require 'spec_helper'
require 'pdf-reader'

describe ReportsPdf do
  let(:user) { create(:user) }
  let(:reviews) { create(:reviews) }
  let(:pdf) { described_class.new(user, [reviews]) }

  let(:report) { ReportsPdf.new }
  # let(:report) { double(ReportsPdf) }
  let(:filename) { "#{Prawn::DATADIR}/images/reports/CEM2031-2012_Page_01.png" }

  xit 'renders pdf correctly' do
    reader = PDF::Reader.new(StringIO.new(pdf.build))
    page = Capybara.string(reader.pages.collect(&:text).join("\n"))
    page.should have_content('text')
  end

  describe '#page_background' do
    it 'places background image' do
      report.should respond_to(:page_background)
      pp report.page_background(filename)
    end
  end
end
