class PdfController < ApplicationController

  def set_defaults
    filename = "#{Rails.root}/app/assets/pdfs/#{@file}.pdf"
    pdf = Prawn::Document.new(
      :template => filename,
      :page_size => "A4"
    )
    send_data pdf.render, type: "application/pdf", disposition: "inline"
  end

  def CEM2030
    # filename = "#{Prawn::DATADIR}/images/reports/CEM2030_production_v1.pdf"
    @file = "CEM2030_production_v1"
    self.set_defaults
  end

  def CEM2034
    # filename = "#{Prawn::DATADIR}/images/reports/CEM2034_production_v1.pdf"
    @file = "CEM2034_production_v1"
    self.set_defaults
  end

  def CEM2035
    # filename = "#{Prawn::DATADIR}/images/reports/CEM2035_production_v1.pdf"
    @file = "CEM2035_production_v1"
    self.set_defaults
  end

  def CEM2040
    # filename = "#{Prawn::DATADIR}/images/reports/CEM2040_production_v1.pdf"
    @file = "CEM2040_production_v1"
    self.set_defaults
  end

  def CEM2045
    # filename = "#{Prawn::DATADIR}/images/reports/CEM2045_production.pdf"
    @file = "CEM2045_production"
    self.set_defaults
  end

  def CEM2050
    # filename = "#{Prawn::DATADIR}/images/reports/CEM2050_production.pdf"
    @file = "CEM2050_production"
    self.set_defaults
  end

  def CEM2051
    # filename = "#{Prawn::DATADIR}/images/reports/CEM2051_production.pdf"
    @file = "CEM2051_production"
    self.set_defaults
  end

  def CEM2052
    # filename = "#{Prawn::DATADIR}/images/reports/CEM2052_production.pdf"
    @file = "CEM2051_production"
    self.set_defaults
  end

  def CEM4601
    # filename = "#{Prawn::DATADIR}/images/reports/CEM4601_production.pdf"
    @file = "CEM4601_production"
    self.set_defaults
  end

=begin

  def CEM2030
    # filename = "#{Prawn::DATADIR}/images/reports/CEM2030_production.pdf"
    filename = "#{Rails.root}/app/assets/pdfs/CEM2030_production.pdf"
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

=end
end
