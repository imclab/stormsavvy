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
  end

  def first_page
    page_background("#{Prawn::DATADIR}/images/reports/CEM2030-2012_Page_01.png")
    report_header_block
    start_new_page
  end

  def second_page
    page_background("#{Prawn::DATADIR}/images/reports/CEM2030-2012_Page_02.png")
    report_header_block
    start_new_page
  end

  def third_page
    page_background("#{Prawn::DATADIR}/images/reports/CEM2030-2012_Page_03.png")
    report_header_block
    start_new_page
  end

  def fourth_page
    page_background("#{Prawn::DATADIR}/images/reports/CEM2030-2012_Page_04.png")
    report_header_block
    start_new_page
  end

end