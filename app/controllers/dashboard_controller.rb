class DashboardController < ApplicationController

  def index
    redirect_to index_path unless user_signed_in?
    if current_user
      @projects = current_user.projects

      # pending_reports
      # @reports = Report.where(:status => "needs_attention")

      # get_ie
      # @inspection_events = []
    end
  end

  def get_ie
    @sites = @projects.sites
    @pending_ie = []
    @sites.each do |s|
      s.inspection_events.each do |ie|
        if ie.completed == false
          @pending_ie << ie
        end
      end
    end

    return @pending_ie
  end

  def get_reports
    @all_reports = []
    @projects.sites.each do |s|
      s.reports.each { |r| @all_reports << r }
    end

    return @all_reports
  end

  def pending_reports
    get_reports
    @pending_reports = []

    @all_reports.each do |r|
      if r.status == 'needs_attention'
        @pending_reports << r
      end
    end

    return @pending_reports
  end
end
