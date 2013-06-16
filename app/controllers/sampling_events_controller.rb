require 'current_user_object'

class SamplingEventsController < InheritedResources::Base
  def index
    @sampling_events = SamplingEvent.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sampling_events }
    end

    if current_user
      cu = CurrentUserObject.new
      user = current_user
      @projects = cu.get_projects(user)
      @sites = cu.get_sites(user)
      @pending_se = cu.get_se(user)
      @sampling_events = cu.all_se(user)
    end

  end

  def new
    @sampling_event = SamplingEvent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sampling_event }
    end
  end

  # GET /sampling_events/1/edit
  def edit
    @sampling_event = SamplingEvent.find(params[:id])
  end

end
