class ReportsPdf < Prawn::Document
  require 'prawn'

  include ReportsHeaderMethods

  def page_background(background_image)
    render_file background_image
    image(background_image,
      :at  => [-bounds.absolute_left, Prawn::Document::PageGeometry::SIZES["A4"][1] - bounds.absolute_bottom - 50],
      :fit => Prawn::Document::PageGeometry::SIZES["A4"]
    )
  end

  # Test method for rendering entire pdf with Prawn.
  def testem_fields(filename)
    pdf = Prawn::Document.new(
      :template => filename,
      :page_size => "A4"
    )
    send_data pdf.render, type: "application/pdf", disposition: "inline"
  end
end
