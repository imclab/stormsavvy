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
    # get_projects(user)
    @sites = []
    sites = user.sites.all
    sites.each do |s|
      @sites << s
    end

    # @projects.each do |p|
    #   p.sites.each do |s|
    #     @sites << s
    #   end
    # end

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

  def all_ie(user)
    get_sites(user)
    @all_ie = []
    @sites.each do |s|
      s.inspection_events.each do |ie|
        @all_ie << ie
      end
    end

    return @all_ie
  end

  def get_se(user)
    get_sites(user)
    @pending_se = []
    @sites.each do |s|
      s.sampling_events.each do |se|
        if se.completed == false
          @pending_se << se
        end
      end
    end

    return @pending_se
  end

  def all_se(user)
    get_sites(user)
    @all_se = []
    @sites.each do |s|
      s.sampling_events.each do |se|
        @all_se << se
      end
    end

    return @all_se
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

  def pending_reports(user)
    get_reports(user)
    @pending_reports = []

    @all_reports.each do |r|
      if r.status == 'needs_attention'
        @pending_reports << r
      end
    end

    return @pending_reports
  end
end
