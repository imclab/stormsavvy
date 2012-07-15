class ReportsController < ApplicationController
  require 'prawn'

  STATIC_REPORTS = %w[CEM2035 CEM2057 CEM2052]

  def index
    #@reports = Report.all
    @completed_reports = Report.completed
    @needs_attention_reports = Report.needs_attention
  end

  def show
    @report = Report.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf do
        # Updated path to assets/images for new CEM 2030
        prawnto :prawn=>{
                         :page_layout=>:portrait, 
                         :page_size => [855,1006], 
                         :background => "#{Rails.root}/app/assets/images/CEM2030-1.png", 
                         :scale => 0.5
                        }, :inline=>true
      end
    end
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(params[:report])
    
    # Testing for report.id
    report_number_id = print(@report.id)
    print "#{report_number_id}\n"

    respond_to do |format|
      if @report.save(params[:report])
        format.html { redirect_to @report, notice: 'Report was successfully created.' }
        format.json { head :no_content }
      else
        format.html { render action: "new" }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end

    # respond_to do |format|
    #   format.html do
    #     render :partial => "/reports/reports"
    #   end
    # end

    
  end

  def edit
    @report = Report.find(params[:id])
  end

  def update
    @report = Report.find(params[:id])
    respond_to do |format|
      if @report.update_attributes(params[:report])
        format.html { redirect_to @report, notice: 'Report was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report = Report.find(params[:id])
    @report.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  def CEM2035
    pdf = Prawn::Document.new
    pdf.text "CEM2035"
    send_data pdf.render, type: "application/pdf", disposition: "inline"
  end

  def CEM2057
    pdf = Prawn::Document.new
    @test = "test"
    pdf.text @test
    send_data pdf.render, type: "application/pdf", disposition: "inline"
  end

  def CEM2052
    pdf = Prawn::Document.new
    pdf.text "CEM2052"
    send_data pdf.render, type: "application/pdf", disposition: "inline"
  end

end
  