class PdfController < ApplicationController
	def CEM2030
    # filename = "#{Prawn::DATADIR}/images/reports/CEM2030_production.pdf"
    filename = "#{Rails.root}/app/assets/pdfs/CEM2030_production.pdf"
    pdf = Prawn::Document.new(
      :template => filename,
      :page_size => "A4"
    )
    send_data pdf.render, type: "application/pdf", disposition: "inline"
  end

	def CEM2034
    # filename = "#{Prawn::DATADIR}/images/reports/CEM2034_production_v1.pdf"
    filename = "#{Rails.root}/app/assets/pdfs/CEM2034_production_v1.pdf"
    pdf = Prawn::Document.new(
      :template => filename,
      :page_size => "A4"
    )
    send_data pdf.render, type: "application/pdf", disposition: "inline"
  end

	def CEM2035
    # filename = "#{Prawn::DATADIR}/images/reports/CEM2035_production_v1.pdf"
    filename = "#{Rails.root}/app/assets/pdfs/CEM2035_production_v1.pdf"
    pdf = Prawn::Document.new(
      :template => filename,
      :page_size => "A4"
    )
    send_data pdf.render, type: "application/pdf", disposition: "inline"
  end

  def CEM4601
    # filename = "#{Prawn::DATADIR}/images/reports/CEM4601_production.pdf"
    filename = "#{Rails.root}/app/assets/pdfs/CEM4601_production.pdf"
    pdf = Prawn::Document.new(
      :template => filename,
      :page_size => "A4"
    )
    send_data pdf.render, type: "application/pdf", disposition: "inline"
  end

  def CEM2052
    pdf = Prawn::Document.new
    pdf.text "CEM2052"
    send_data pdf.render, type: "application/pdf", disposition: "inline"
  end

  def CEM2057
    pdf = Prawn::Document.new
    @test = "test"
    pdf.text @test
    send_data pdf.render, type: "application/pdf", disposition: "inline"
  end
end
