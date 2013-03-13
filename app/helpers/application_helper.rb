module ApplicationHelper

  def title
    "Storm Savvy"
  end

  def template_id
    {:id => params[:action] }
  end

  def template_class
    unless params[:controller].nil?
      {:class => "#{params[:controller].gsub(/\//,'-')} #{params[:action]}"}
    else
      {:class => "FIXME"}
    end
  end

  def is_public_home?
    if params[:controller] == 'pages' && params[:action] == "index" && !current_user
      true
    end
  end

  def twitterized_type(type) # Handles bootstrap message types.
    case type
      when :alert
        "warning"
      when :error
        "error"
      when :notice
        "info"
      when :success
        "success"
      when :notice
        "notice"
      else
        type.to_s
    end
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def projects
    @projects = current_user.projects.all
  end

  def sites
    @sites = current_user.sites.all
  end

  def weather_events
    @weather_events = WeatherEvent.all
  end

  def inspection_events
    @inspection_events = InspectionEvent.all
  end

  def completed_reports
    @completed_reports = Report.completed
  end

  def needs_attention_reports
    @needs_attention_reports = Report.needs_attention
  end
end
