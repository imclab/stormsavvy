class DashboardController < ApplicationController

  # the pig pen
  def index
    redirect_to pages_index_path unless user_signed_in?
    @projects = Project.all
    @sites = Site.all
    @weather_events = WeatherEvent.all
    @inspection_events = InspectionEvent.all
  end

  def edit
  end

  private

end
