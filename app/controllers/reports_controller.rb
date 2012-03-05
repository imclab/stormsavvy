class ReportsController < ApplicationController
  require 'prawn'

  STATIC_REPORTS = %w[CEM2035 CEM2057 CEM2052]

  def index
    @completed_reports = Report.completed
    @needs_attention_reports = Reports.needs_attention
  end

  def show
    @report = Report.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf do
        prawnto :prawn=>{:page_layout=>:portrait, :page_size => [855,1006], :background => "#{Rails.root}/public/reports/cem2030/cem-2030-1.png", :scale => 0.5}, :inline=>true
      end
    end
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(params[:report])
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
    pdf.text "CEM2057"
    send_data pdf.render, type: "application/pdf", disposition: "inline"
  end

end
