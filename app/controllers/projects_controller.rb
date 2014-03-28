class ProjectsController < ApplicationController
  require 'carmen'
  include Carmen

  before_filter :authenticate_user!
  protect_from_forgery

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
    # @project = current_user.projects.find(params[:id])

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
    # @project = current_user.projects.find(params[:id])

    respond_to do |format|
      format.html { render html: @project, :notice => 'Error: See details below.',
                    :flash => { :error => 'Error!' } }
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
    # @project = current_user.projects.find(params[:id])
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])

    # @project = current_user.projects.build(params[:project])
    # @project.save!

    # @project = current_user.projects.find(params[:project])
    # @project.build
    # @project.save

    # @project = Project.new(params[:project])
    # @project.user = current_user
    # pp @project.user

    # @project.save!
    # pp @project.new_record?

    if @project.save
      pp 'Project Saved!'
    else
      pp 'WTF??'
    end

    respond_to do |format|
      if @project.save
        # format.html { redirect_to(@project, :flash => { :success => 'Project was successfully created.'}) }
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { redirect_to new_project_path, flash.now[:error] => 'Error: See details below.' }
        #format.html { redirect_to new_project_site_path, flash.now[:error] => 'Error: See details below.' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
        # :flash => { :error => 'Please fix the problems shown.' } }
        # format.html { render action: "new", notice: 'Project was unsuccessfully created.' }
        # format.html { render action: "new", flash.now[:error] = "Error: See details below." }
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
        format.html { flash.now[:error] = "Error: See details below."
                      render action: "edit" }
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
      format.html { redirect_to projects_path, notice: 'Project was successfully deleted.' }
      format.json { head :no_content }
    end
  end
end
