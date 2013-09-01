class DashboardController < ApplicationController
  skip_before_filter :authenticate_user!

  def index
    redirect_to index_path unless user_signed_in?
    if user_signed_in?
      @projects = current_user.projects.includes(sites: [:reports, :inspection_events])
      @sites = @projects.each.collect { |p| p.sites }.flatten
      @pending_ie = @sites.collect{|s| s.inspection_events.needs_attention }.flatten
      @pending_reports = @sites.collect{|s| s.reports.select{ |r| r.status == 'needs_attention' } }.flatten
    end
  end
end
