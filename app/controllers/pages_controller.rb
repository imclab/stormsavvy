class PagesController < ApplicationController
  def index
    if user_signed_in?
      redirect_to sites_path
    end
  end

  def about
  end

  def terms
  end

  def about_us
  end

  def faq
  end

  def privacy
  end

  def contact
  end

  def plans
  end

  def features
  end

  def team
  end
end
