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

  def first_page
    page_background("#{Prawn::DATADIR}/images/reports/CEM2030-2012_Page_01.png")
    full_report_header_block
    start_new_page
  end

  def second_page
    page_background("#{Prawn::DATADIR}/images/reports/CEM2030-2012_Page_02.png")
    simple_report_header_block
    start_new_page
  end

  def third_page
    page_background("#{Prawn::DATADIR}/images/reports/CEM2030-2012_Page_03.png")
    simple_report_header_block
    start_new_page
  end

  def fourth_page
    page_background("#{Prawn::DATADIR}/images/reports/CEM2030-2012_Page_04.png")
    simple_report_header_block
    start_new_page
  end

  def fifth_page
    page_background("#{Prawn::DATADIR}/images/reports/CEM2030-2012_Page_05.png")
    simple_report_header_block
    start_new_page
  end

  def sixth_page
    page_background("#{Prawn::DATADIR}/images/reports/CEM2030-2012_Page_06.png")
    simple_report_header_block
    start_new_page
  end  

  def seventh_page
    page_background("#{Prawn::DATADIR}/images/reports/CEM2030-2012_Page_07.png")
    simple_report_header_block
    start_new_page
  end  

  def eighth_page
    page_background("#{Prawn::DATADIR}/images/reports/CEM2030-2012_Page_08.png")
    simple_report_header_block
    start_new_page
  end  

  def ninth_page
    # Do not start new page on last page!
    page_background("#{Prawn::DATADIR}/images/reports/CEM2030-2012_Page_09.png")
    simple_report_header_block
  end  
end
