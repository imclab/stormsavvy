class PagesController < ApplicationController
  before_filter :authenticate_user!, 
    :except => [:index, :about, :terms, :about_us, :privacy]

  def index
    if user_signed_in?
      redirect_to sites_path
    end
  end

  def pdf
  end

  def about
  end

  def terms
  end

  def about_us
  end

  def privacy
  end
end
