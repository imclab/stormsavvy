class ReportsPdf < Prawn::Document
  include ReportsHeaderMethods

  def page_background(background_image)
    image background_image,
    :at  => [-bounds.absolute_left, Prawn::Document::PageGeometry::SIZES["A4"][1] - bounds.absolute_bottom - 50],
    :fit => Prawn::Document::PageGeometry::SIZES["A4"]
  end
end