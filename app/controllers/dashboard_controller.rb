class DashboardController < ApplicationController
  skip_before_filter :authenticate_user!

  def index
    redirect_to index_path unless user_signed_in?
    if current_user
      get_projects
      # @projects = current_user.projects.all

      get_sites
      # @sites = current_user.sites.all

      pending_reports
      # @reports = Report.where(:status => "needs_attention")

      get_ie
      # @inspection_events = []
    end
  end

  def get_projects
    @projects = current_user.projects
  end

  def get_sites
    get_projects
    @sites = []
    @projects.each do |p|
      p.sites.each do |s|
        @sites << s
      end
    end

    return
  end

  def get_ie
    get_sites
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
    get_sites
    @all_reports = []
    @sites.each do |s|
      s.reports.each do |r|
        @all_reports << r
      end
    end

    if user_signed_in?
      @projects = current_user.projects.includes(sites: [:reports, :inspection_events])
      @sites = @projects.each.collect { |p| p.sites }.flatten
      @pending_ie = @sites.collect{|s| s.inspection_events.needs_attention }.flatten
      @pending_reports = @sites.collect{|s| s.reports.select{ |r| r.status == 'needs_attention' } }.flatten
    end
  end
end
