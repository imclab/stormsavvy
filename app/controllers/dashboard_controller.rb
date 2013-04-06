class DashboardController < ApplicationController

  def index
    redirect_to index_path unless user_signed_in?
    if current_user
      @projects = current_user.projects.all
      @sites = current_user.sites.all

      @reports = Report.where(:status => "needs_attention")

      @inspection_events = []
      current_user.sites.each do |s|
        s.inspection_events.each do |ie|
          if ie.completed.blank?
            'No inspection events.'
          else
            @inspection_events[] << ie.completed
          end
        end
      end

      # @inspection_events = InspectionEvent.where(:completed => false)
      # @inspection_events = InspectionEvent.needs_attention.all

      # @completed_reports = Report.completed
      # @needs_attention_reports = Report.needs_attention

      # Comment back in along with spec
      # @weather_events = WeatherEvent.all
    end
  end

  def get_reports
    @reports = []

    current_user.reports.each do |r|
      @reports[] << r
    end
    return @reports
  end

  def pending_reports
    get_reports
    pending_reports = []

    @reports.each do |r|
      if r.status == "needs_attention"
        pending_reports[] << r
      else
        'No pending reports.'
      end
    end
  end

end
