require 'spec_helper'
require 'pdf-reader'

describe PdfController do

  include Devise::TestHelpers

  let!(:user) {
    FactoryGirl.create(:user)
  }
  let!(:format) { double(PdfController) }

  before :each do
    format.stub(:CEM2030).and_return("CEM2030.pdf")
    controller.stub(:respond_to).and_yield(format)
    sign_in user
  end

  it "renders methods with 200 code" do
    # get :CEM2034
    # response.code.should eq("200")
    # get :CEM2035
    # response.code.should eq("200")
    # get :CEM2040
    # response.code.should eq("200")
    # get :CEM2045
    # response.code.should eq("200")
    # get :CEM2050
    # response.code.should eq("200")
    # get :CEM2051
    # response.code.should eq("200")
    # get :CEM2052
    # response.code.should eq("200")
    # get :CEM4601
    # response.code.should eq("200")
  end

  describe '#CEM2030' do
    it "renders a pdf file" do
      format.stub(:CEM2030).and_return("CEM2030.pdf")
      controller.stub(:respond_to).and_yield(format)

      get :CEM2030
      # get :CEM2030, format: 'pdf'
      # get :CEM2030, :id => @report.to_param, :format => 'pdf'

      response.code.should eq("200")
      response.content_type.should eq("application/pdf")
      response.headers["Content-Disposition"].should eq("inline")
      # controller.should_receive(:CEM2030)
    end

    xit 'reads the pdf' do
      File.open("CEM2030.pdf", "rb") do |io|
        reader = PDF::Reader.new(io)
        puts reader.info
        puts reader.pdf_version
        puts reader.info
        puts reader.metadata
        puts reader.page_count
      end
    end
  end

  describe '#CEM2034' do
    it "renders a pdf file" do
      format.stub(:CEM2034).and_return("CEM2034.pdf")
      controller.stub(:respond_to).and_yield(format)

      get :CEM2034
      response.code.should eq("200")
      response.content_type.should eq("application/pdf")
      response.headers["Content-Disposition"].should eq("inline")
    end
  end

  describe '#CEM2035' do
    it "renders a pdf file" do
      format.stub(:CEM2035).and_return("CEM2035.pdf")
      controller.stub(:respond_to).and_yield(format)

      get :CEM2035
      response.code.should eq("200")
      response.content_type.should eq("application/pdf")
      response.headers["Content-Disposition"].should eq("inline")
    end
  end

  describe '#CEM2040' do
    it "renders a pdf file" do
      format.stub(:CEM2040).and_return("CEM2040.pdf")
      controller.stub(:respond_to).and_yield(format)

      get :CEM2040
      response.code.should eq("200")
      response.content_type.should eq("application/pdf")
      response.headers["Content-Disposition"].should eq("inline")
    end
  end

  describe '#CEM2045' do
    it "renders a pdf file" do
      format.stub(:CEM2045).and_return("CEM2045.pdf")
      controller.stub(:respond_to).and_yield(format)

      get :CEM2045
      response.code.should eq("200")
      response.content_type.should eq("application/pdf")
      response.headers["Content-Disposition"].should eq("inline")
    end
  end

  describe '#CEM4601' do
    it "renders a pdf file" do
      format.stub(:CEM4601).and_return("CEM4601.pdf")
      controller.stub(:respond_to).and_yield(format)

      get :CEM4601
      response.code.should eq("200")
      response.content_type.should eq("application/pdf")
      response.headers["Content-Disposition"].should eq("inline")
    end
  end
end
