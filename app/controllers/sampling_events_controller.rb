class SamplingEventsController < InheritedResources::Base

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