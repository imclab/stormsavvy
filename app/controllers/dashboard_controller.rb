class DashboardController < ApplicationController

  # the pig pen
  def index
    redirect_to index_path unless user_signed_in?
    if current_user
      @projects = current_user.projects.all
      @sites = current_user.sites.all
=begin
      inspection_events = @sites.each do |site|
        site.inspection_events.where(:completed => false)
      end
      @inspection_events = inspection_events
=end
      @inspection_events = InspectionEvent.where(:completed => false)
      # @inspection_events = InspectionEvent.needs_attention.all

      @completed_reports = Report.completed
      @needs_attention_reports = Report.needs_attention

      # Comment back in along with spec
      # @weather_events = WeatherEvent.all
    end
  end
end
