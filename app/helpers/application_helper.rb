module ApplicationHelper

  def title
    "StormSavvy"
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
end
