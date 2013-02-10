require 'spec_helper'
require 'pdf/inspector'

# encoding: utf-8

# require File.join(File.expand_path(File.dirname(__FILE__)), "spec_helper")

describe "#text_rendering_mode" do

  it "should draw the text rendering mode to the document" do
    create_pdf
    @pdf.text_rendering_mode(:stroke) do
      @pdf.text("hello world")
    end
    contents = PDF::Inspector::Text.analyze(@pdf.render)
    contents.text_rendering_mode.first.should == 1
  end

  it "should not draw the text rendering mode to the document" +
    " when the new mode matches the old" do
    create_pdf
    @pdf.text_rendering_mode(:fill) do
      @pdf.text("hello world")
    end
    contents = PDF::Inspector::Text.analyze(@pdf.render)
    # contents.text_rendering_mode.should.be.empty
  end
  it "should restore character spacing to 0" do
    create_pdf
    @pdf.text_rendering_mode(:stroke) do
      @pdf.text("hello world")
    end
    contents = PDF::Inspector::Text.analyze(@pdf.render)
    contents.text_rendering_mode.should == [1,0]
  end
  it "should function as an accessor when no parameter given" do
    create_pdf
    @pdf.text_rendering_mode(:fill_stroke) do
      @pdf.text("hello world")
      @pdf.text_rendering_mode.should == :fill_stroke
    end
    @pdf.text_rendering_mode.should == :fill
  end
  it "should raise an exception when passed an invalid mode" do
    create_pdf
    # lambda { @pdf.text_rendering_mode(-1) }.should.raise(ArgumentError)
    # lambda { @pdf.text_rendering_mode(8) }.should.raise(ArgumentError)
    # lambda { @pdf.text_rendering_mode(:flil) }.should.raise(ArgumentError)
  end
end

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