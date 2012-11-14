class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :redirect_subdomain
=begin
  def redirect_subdomain
    if request.env["HTTP_HOST"] == "pdf.stormsavvy.com"
      redirect_to "http://pdfff.herokuapp.com/"
    end
  end
=end
  def title
    "StormSavvy"
  end
end
