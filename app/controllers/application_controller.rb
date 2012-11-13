class ApplicationController < ActionController::Base
  protect_from_forgery

  def title
    "StormSavvy"
  end
end
