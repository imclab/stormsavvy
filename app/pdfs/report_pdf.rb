class ReportPdf < Prawn::Document

  def initialize(report, view)
    super(top_margin: 70, background: "http://placehold.it/400x400")
    @report = report
    @view = view
    report_header
  end

  def report_header
    text "STATE OF CALIFORNIA * DEPARTMENT OF TRANSPORTATION"
  end

end