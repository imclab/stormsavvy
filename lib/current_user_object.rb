class CurrentUserObject
  def get_projects
    @projects = []
    projects = current_user.projects.all
    projects.each do |p|
      @projects << p
    end

    return @projects
  end

  def get_sites
    get_projects
    @sites = []
    @projects.each do |p|
      p.sites.each do |s|
        @sites << s
      end
    end

    return @sites
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
end
