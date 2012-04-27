require 'spec_helper'
require 'pdf/inspector'

describe "prawn report" do

  before(:each) do
    @report = FactoryGirl.create(:report)
  end

	describe "when creating pdf" do
		# pdf = Prawn::Document.new
  	# pdf.text "CEM2030"
  	# pdf.render_file "CEM2030.pdf"

    # send_data pdf.render, type: "application/pdf", disposition: "inline"
		# @pdf.pages.each do |page|
		#   puts page.fonts
		#   puts page.text
		#   puts page.raw_content
		#  end

		# Previous call from pdf-reader gem
	  # page_counter = PDF::Inspector.analyze(pdf)
	  # page_counter.pages.size.should == 1
	  # pdf.page_count.should == 1
	end
end