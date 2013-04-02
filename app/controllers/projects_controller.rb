class ProjectsController < ApplicationController
  require 'carmen'
  include Carmen

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])

    # dashboard controller variables
    @sites = @project.sites
    @weather_events = WeatherEvent.all
    @inspection_events = InspectionEvent.all
    @completed_reports = Report.completed
    @needs_attention_reports = Report.needs_attention
    # @project = current_user.projects.find(params[:id])
    # @projects = current_user.projects.all

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new
    @sites = @project.sites.build
    respond_to do |format|
      format.html { render html: @project, :notice => 'See details below.',
                    :flash => { :error => 'Error!' } }
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = current_user.projects.find(params[:id])
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = current_user.projects.build(params[:project])
    @project.save
    respond_to do |format|
      if @project.save
        # format.html { redirect_to(@project, :flash => { :success => 'Project was successfully created.'}) }
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        #binding.pry
        #format.html { render action: "new", notice: 'Project was unsuccessfully created.' }
        format.html { flash.now[:error] = "Flash now sent from bad form"
                      render action: "new" }#, :flash => { :error => 'Please fix the problems shown.' } }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = current_user.projects.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        # Flash message test using Twitter Bootstrap applicaton helper method
        # flash[:notice] = "Flash message test"
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end
end
