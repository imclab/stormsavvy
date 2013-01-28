class DashboardController < ApplicationController

  # the pig pen
  def index
    redirect_to index_path unless user_signed_in?
    if current_user
      @projects = current_user.projects.all
      @sites = Site.all
      @weather_events = WeatherEvent.all
      @inspection_events = InspectionEvent.all

      @completed_reports = Report.completed
      @needs_attention_reports = Report.needs_attention
    end
  end

end
