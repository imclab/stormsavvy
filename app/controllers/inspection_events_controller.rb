require 'current_user_object'

class InspectionEventsController < ApplicationController

  # GET /inspection_events
  # GET /inspection_events.json
  def index
    if current_user
      cu = CurrentUserObject.new
      user = current_user
      @sites = cu.get_sites(user)
      @pending_ie = cu.get_ie(user)
      @inspection_events = cu.all_ie(user)
    end

    # @inspection_events = InspectionEvent.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @inspection_events }
    end

  end

  # GET /inspection_events/1
  # GET /inspection_events/1.json
  def show
    @inspection_event = InspectionEvent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inspection_event }
    end
  end

  # GET /inspection_events/new
  # GET /inspection_events/new.json
  def new
    @inspection_event = InspectionEvent.new

    respond_to do |format|
      format.html { render html: @inspection_event, :notice => 'Error: See details below.',
                    :flash => { :error => 'Error!' } }
      format.json { render json: @inspection_event }
    end
  end

  # GET /inspection_events/1/edit
  def edit
    @inspection_event = InspectionEvent.find(params[:id])
  end

  # POST /inspection_events
  # POST /inspection_events.json
  def create
    @inspection_event = InspectionEvent.new(params[:inspection_event])

    respond_to do |format|
      if @inspection_event.save
        format.html { redirect_to @inspection_event, notice: 'Inspection event was successfully created.' }
        format.json { render json: @inspection_event, status: :created, location: @inspection_event }
      else
        format.html { flash.now[:error] = "Error: See details below."
                      render action: "new" }
        format.json { render json: @inspection_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /inspection_events/1
  # PUT /inspection_events/1.json
  def update
    @inspection_event = InspectionEvent.find(params[:id])

    respond_to do |format|
      if @inspection_event.update_attributes(params[:inspection_event])
        format.html { redirect_to @inspection_event, notice: 'Inspection event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { flash.now[:error] = "Error: See details below."
                      render action: "edit" }
        format.json { render json: @inspection_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inspection_events/1
  # DELETE /inspection_events/1.json
  def destroy
    @inspection_event = InspectionEvent.find(params[:id])
    @inspection_event.destroy

    respond_to do |format|
      format.html { redirect_to inspection_events_path, notice: 'Inspection event was successfully deleted.' }
      format.json { head :no_content }
    end
  end
end
