require 'prawn'

class FirstReport < ReportsPdf

  def initialize(report, view, options)
    super top_margin: 70
    @report = report
    @view = view

    build_report
  end

  def build_report
    first_page
    second_page
    third_page
    fourth_page
    fifth_page
    sixth_page
    seventh_page
    eighth_page
    ninth_page
  end

  # Test method for rendering entire pdf with Prawn.
  def testem_page
    testem_fields(
      "#{Prawn::DATADIR}/images/reports/CEM2030-2012_Page_01.pdf"
      # "#{Rails.root}/app/assets/images/reports/testem_fields.pdf"
    )
    start_new_page
  end

  def first_page
    page_background("#{Prawn::DATADIR}/images/reports/CEM2030-2012_Page_01.pdf")
    # full_report_header_block

    # filename = "#{Prawn::DATADIR}/images/reports/CEM2030-2012_Page_01.pdf"
    # pdf = Prawn::Document.new(
    #   :template => filename,
    #   :page_size => "A4"
    # )
    # send_data pdf.render, type: "application/pdf", disposition: "inline"

    start_new_page
  end

  def second_page
    page_background("#{Prawn::DATADIR}/images/reports/CEM2030-2012_Page_02.pdf")    
    # simple_report_header_block

    # filename = "#{Prawn::DATADIR}/images/reports/CEM2030-2012_Page_02.pdf"
    # pdf = Prawn::Document.new(
    #   :template => filename,
    #   :page_size => "A4"
    # )
    start_new_page
  end

  def third_page
    page_background("#{Prawn::DATADIR}/images/reports/CEM2030-2012_Page_03.pdf")
    # simple_report_header_block

    # filename = "#{Prawn::DATADIR}/images/reports/CEM2030-2012_Page_03.pdf"
    # pdf = Prawn::Document.new(
    #   :template => filename,
    #   :page_size => "A4"
    # )
    start_new_page
  end

  def fourth_page
    page_background("#{Prawn::DATADIR}/images/reports/CEM2030-2012_Page_04.pdf")
    # simple_report_header_block

    # filename = "#{Prawn::DATADIR}/images/reports/CEM2030-2012_Page_04.pdf"
    # pdf = Prawn::Document.new(
    #   :template => filename,
    #   :page_size => "A4"
    # )
    start_new_page
  end

  def fifth_page
    page_background("#{Prawn::DATADIR}/images/reports/CEM2030-2012_Page_05.pdf")
    # simple_report_header_block

    # filename = "#{Prawn::DATADIR}/images/reports/CEM2030-2012_Page_05.pdf"
    # pdf = Prawn::Document.new(
    #   :template => filename,
    #   :page_size => "A4"
    # )
    start_new_page
  end

  def sixth_page
    page_background("#{Prawn::DATADIR}/images/reports/CEM2030-2012_Page_06.pdf")
    # simple_report_header_block

    # filename = "#{Prawn::DATADIR}/images/reports/CEM2030-2012_Page_06.pdf"
    # pdf = Prawn::Document.new(
    #   :template => filename,
    #   :page_size => "A4"
    # )
    start_new_page
  end  

  def seventh_page
    page_background("#{Prawn::DATADIR}/images/reports/CEM2030-2012_Page_07.pdf")
    # simple_report_header_block

    # filename = "#{Prawn::DATADIR}/images/reports/CEM2030-2012_Page_02.pdf"
    # pdf = Prawn::Document.new(
    #   :template => filename,
    #   :page_size => "A4"
    # )
    start_new_page
  end  

  def eighth_page
    page_background("#{Prawn::DATADIR}/images/reports/CEM2030-2012_Page_08.pdf")
    # simple_report_header_block

    # filename = "#{Prawn::DATADIR}/images/reports/CEM2030-2012_Page_02.pdf"
    # pdf = Prawn::Document.new(
    #   :template => filename,
    #   :page_size => "A4"
    # )
    start_new_page
  end  

  def ninth_page
    # Do not start new page on last page!
    page_background("#{Prawn::DATADIR}/images/reports/CEM2030-2012_Page_09.pdf")
    # simple_report_header_block

    # filename = "#{Prawn::DATADIR}/images/reports/CEM2030-2012_Page_09.pdf"
    # pdf = Prawn::Document.new(
    #   :template => filename,
    #   :page_size => "A4"
    # )
  end  
end
