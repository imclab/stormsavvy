class WeatherEventsController < ApplicationController

  before_filter :authenticate_user!

  # GET /weather_events
  # GET /weather_events.json
  def index
    @weather_events = WeatherEvent.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @weather_events }
    end
  end

  # GET /weather_events/1
  # GET /weather_events/1.json
  def show
    @weather_event = WeatherEvent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @weather_event }
    end
  end

  # GET /weather_events/new
  # GET /weather_events/new.json
  def new
    @weather_event = WeatherEvent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @weather_event }
    end
  end

  # GET /weather_events/1/edit
  def edit
    @weather_event = WeatherEvent.find(params[:id])
  end

  # POST /weather_events
  # POST /weather_events.json
  def create
    @weather_event = WeatherEvent.new(params[:weather_event])

    respond_to do |format|
      if @weather_event.save
        format.html { redirect_to @weather_event, notice: 'Weather event was successfully created.' }
        format.json { render json: @weather_event, status: :created, location: @weather_event }
      else
        format.html { render action: "new" }
        format.json { render json: @weather_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /weather_events/1
  # PUT /weather_events/1.json
  def update
    @weather_event = WeatherEvent.find(params[:id])

    respond_to do |format|
      if @weather_event.update_attributes(params[:weather_event])
        format.html { redirect_to @weather_event, notice: 'Weather event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @weather_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weather_events/1
  # DELETE /weather_events/1.json
  def destroy
    @weather_event = WeatherEvent.find(params[:id])
    @weather_event.destroy

    respond_to do |format|
      format.html { redirect_to weather_events_path }
      format.json { head :no_content }
    end
  end
end
