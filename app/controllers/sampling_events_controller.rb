require 'current_user_object'

class SamplingEventsController < ApplicationController
# class SamplingEventsController < InheritedResources::Base

  # GET /sampling_events
  # GET /sampling_events.json
  def index
    if current_user
      cu = CurrentUserObject.new
      user = current_user
      @sites = cu.get_sites(user)
      @pending_se = cu.get_se(user)
      @sampling_events = cu.all_se(user)
    end
  end

  # GET /sampling_events/1
  # GET /sampling_events/1.json
  def show
    @sampling_event = SamplingEvent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sampling_event }
    end
  end

  def new
    @sampling_event = SamplingEvent.new

    respond_to do |format|
      format.html { render html: @sampling_event, :notice => 'Error: See details below.',
                    :flash => { :error => 'Error!' } }
      format.json { render json: @sampling_event }
    end
  end

  # GET /sampling_events/1/edit
  def edit
    @sampling_event = SamplingEvent.find(params[:id])
  end

  # POST /sampling_events
  # POST /sampling_events.json
  def create
    @sampling_event = SamplingEvent.new(params[:sampling_event])

    respond_to do |format|
      if @sampling_event.save
        format.html { redirect_to @sampling_event, notice: 'Sampling event was successfully created.' }
        format.json { render json: @sampling_event, status: :created, location: @sampling_event }
      else
        format.html { flash.now[:error] = "Error: See details below."
                      render action: "new" }
        format.json { render json: @sampling_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sampling_events/1
  # PUT /sampling_events/1.json
  def update
    @sampling_event = SamplingEvent.find(params[:id])

    respond_to do |format|
      if @sampling_event.update_attributes(params[:sampling_event])
        format.html { redirect_to @sampling_event, notice: 'Sampling event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { flash.now[:error] = "Error: See details below."
                      render action: "edit" }
        format.json { render json: @sampling_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sampling_events/1
  # DELETE /sampling_events/1.json
  def destroy
    @sampling_event = SamplingEvent.find(params[:id])
    @sampling_event.destroy

    respond_to do |format|
      format.html { redirect_to sampling_events_url, notice: 'Sampling event was successfully deleted.' }
      format.json { head :no_content }
    end
  end
end
