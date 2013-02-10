class ReportsController < ApplicationController
  require 'prawn'

  # Include CEM report methods below to show up in routes.
  STATIC_REPORTS = %w[CEM2030 CEM2034 CEM2035 CEM2040 CEM2045 CEM2050 CEM2051 CEM2052 CEM4601]

  def index
    @reports = Report.all
    @completed_reports = Report.completed
    @needs_attention_reports = Report.needs_attention
  end

  def show
    @report = Report.find(params[:id])
    respond_to do |format|
      format.html
      # format.pdf do
      #   pdf = FirstReport.new @report, view_context, background: "#{Prawn::DATADIR}/images/reports/CEM2031-2012_Page_01.png"
      #   pdf = FirstReport.new @report, view_context, background: "#{Prawn::DATADIR}/images/reports/testem_fields.pdf"
      #   send_data pdf.render, filename: "report_#{@report.id}.pdf", type: "application/pdf", disposition: "inline"
      # end
    end
  end

  def new
    @report = Report.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @report }
    end
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
      format.html { redirect_to reports_path }
      format.json { head :no_content }
    end
  end

  # def CEM2030
  #   # filename = "#{Rails.root}/app/assets/images/reports/testem_fields.pdf"
  #   # @report = Report.new(params[:report])
  #   # redirect_to @report

  #   # @report = Report.create
  #   # pdf = FirstReport.new @report, view_context, background: "#{Rails.root}/app/assets/images/reports/CEM2030-2012_Page_01.pdf"
  #   # send_data pdf.render, type: "application/pdf", disposition: "inline"


  #   # filename = "#{Prawn::DATADIR}/images/reports/CEM2030-2012_Page_01.pdf"
  #   filename = "#{Rails.root}/app/assets/pdfs/CEM2030_production.pdf"
  #   pdf = Prawn::Document.new(
  #     :template => filename,
  #     :page_size => "A4"
  #   )
  #   send_data pdf.render, type: "application/pdf", disposition: "inline"
  # end

end
