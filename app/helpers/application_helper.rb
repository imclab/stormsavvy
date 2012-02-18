module ApplicationHelper

  def template_id
    {:id => params[:action] }
  end

  def template_class
    {:class => "#{params[:controller].gsub(/\//,'-')} #{params[:action]}"}
  end
end
