class ApplicationController < ActionController::Base
  protect_from_forgery

  def title
    "Storm Savvy"
  end
end
