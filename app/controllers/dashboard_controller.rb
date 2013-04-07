class DashboardController < ApplicationController

  def index
    redirect_to index_path unless user_signed_in?
    if current_user

      get_projects
      # @projects = current_user.projects.all

      @sites = current_user.sites.all
      @reports = Report.where(:status => "needs_attention")

      @inspection_events = []
      current_user.sites.each do |s|
        s.inspection_events.each do |ie|
          if ie.completed.blank?
            'No inspection events.'
          else
            @inspection_events << ie.completed
          end
        end
      end
    end
  end

  def get_projects
    @projects = []
    projects = current_user.projects.all

    if projects.blank?
      'No active projects, start one by clicking \'new project\'.'
    else
      projects.each do |p|
        @projects << p
      end
    end

    return @projects
  end

  def get_sites
    get_projects
    @sites = []
    @projects.each do |s|
      @sites << s
    end

    return @sites
  end

  def get_ie
    get_sites
    @completed_ie = []
    @sites.each do |s|
      s.inspection_events.each do |ie|
        @completed_ie << ie.completed
      end
    end

    if @completed_ie.blank?
      'No pending inspections'
    else
      return @completed_ie
    end
  end

  def get_reports
    @reports = []
    get_sites.each do |r|
      @reports[] << r
    end

    return @all_reports
  end

  def pending_reports
    get_reports
    @pending_reports = []

    @all_reports.each do |r|
      if r.status == "needs_attention"
        @pending_reports[] << r
      else
        'No pending reports.'
      end
    end

    return @pending_reports
  end
end
