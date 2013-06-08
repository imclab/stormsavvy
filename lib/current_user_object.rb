class CurrentUserObject
  def get_projects(user)
    @projects = []
    projects = user.projects.all
    projects.each do |p|
      @projects << p
    end

    return @projects
  end

  def get_sites(user)
    get_projects(user)
    @sites = []
    @projects.each do |p|
      p.sites.each do |s|
        @sites << s
      end
    end

    return @sites
  end

  def get_ie(user)
    get_sites(user)
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

  def get_reports(user)
    get_sites(user)
    @all_reports = []
    @sites.each do |s|
      s.reports.each do |r|
        @all_reports << r
      end
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
