module ApplicationHelper

  def template_id
    {:id => params[:action] }
  end

  def template_class
    {:class => "#{params[:controller].gsub(/\//,'-')} #{params[:action]}"}
  end

  def is_public_home?
    if params[:controller] == 'pages' && params[:action] == "index" && !current_user
      true
    end
  end
end
