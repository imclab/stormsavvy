class ApplicationController < ActionController::Base
  protect_from_forgery

  def title
    "Stormsavvy.com"
  end
end
