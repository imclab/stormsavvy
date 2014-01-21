class SitesController < ApplicationController
  respond_to :json

  # GET /sites
  # GET /sites.json
  def index

    sites = Site.all
    @sites = current_user.sites
    @needs_attention_reports = Report.needs_attention

    # respond_to do |format|
    #   format.html # index.html.erb
    #   format.json { render json: @sites }
    # end

    respond_with(sites) do |format|
      format.html # { redirect_to site_user_sites_path }
      format.json { render :json => @sites.as_json }
    end
  end

  # GET /sites/1
  # GET /sites/1.json
  def show
    @site = Site.find(params[:id])
    @forecast_table = @site.forecast_table
    @completed_reports = @site.reports.completed
    @needs_attention_reports = @site.reports.needs_attention

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @site }
    end
  end

  # GET /sites/new
  # GET /sites/new.json
  def new
    @site = Site.new

    respond_to do |format|
      format.html { render html: @site, :notice => 'Error: See details below.',
                    :flash => { :error => 'Error!' } }
      format.json { render json: @site }
    end
  end

  # GET /sites/1/edit
  def edit
    @site = Site.find(params[:id])
    # @project = Project.find(params[:project_id])
    # @site = @project.sites.find(params[:id])
  end

  # POST /sites
  # POST /sites.json
  def create
    # @site = Site.new(params[:site])

    @site = current_user.sites.build(params[:site])
    # @site.lat = @lat
    # @site.long = @long
    # @site.save

    Rails.logger.debug 'User email is ' + @site.user.email.to_s
    Rails.logger.debug 'Site lat is ' + @site.lat.to_s
    Rails.logger.debug 'Site long is ' + @site.long.to_s

    # @project = Project.find(params[:project_id])
    # @site = @project.sites.build(params[:site])

    respond_to do |format|
      if @site.save
        format.html { redirect_to @site, notice: 'Site was successfully created.' }
        # format.html { redirect_to project_site_path(@site.project_id, @site),
        #               notice: 'Site was successfully created.' }
        format.json { render json: @site, status: :created, location: @site }
      else
        format.html { flash.now[:error] = "Error: See details below."
                      render action: "new" }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sites/1
  # PUT /sites/1.json
  def update
    @site = Site.find(params[:id])

    respond_to do |format|
      if @site.update_attributes(params[:site])
        format.html { redirect_to site_path(@site), notice: 'Site was successfully updated.' }
        # format.html { redirect_to project_site_path(@site.project, @site), notice: 'Site was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { flash.now[:error] = "Error: See details below."
                      render action: "edit" }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.json
  def destroy
    @site = Site.find(params[:id])
    @site.destroy

    respond_to do |format|
      format.html { redirect_to sites_path, notice: 'Site was successfully deleted.' }
      format.json { head :no_content }
    end
  end
end
