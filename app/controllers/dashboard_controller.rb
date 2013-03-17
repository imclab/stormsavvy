class DashboardController < ApplicationController

  # the pig pen
  def index
    redirect_to index_path unless user_signed_in?
    if current_user

      # throws no method error on projects
      # @projects = current_user.projects.all
      # @sites = current_user.sites.all

      @weather_events = WeatherEvent.all

      @inspection_events = InspectionEvent.all
      # @inspection_events = InspectionEvent.needs_attention.all

      @completed_reports = Report.completed
      @needs_attention_reports = Report.needs_attention
    end
  end

end
