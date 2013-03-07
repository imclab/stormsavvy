require 'date'
require 'time'

class InspectionEventWorkflow < ActiveRecord::Base

  attr_accessible :amount_of_rain,
    :cem2023,
    :cem2024,
    :cem2030,
    :cem2034,
    :cem2035,
    :cem2040,
    :chance_of_rain,
    :during_storm_inspection,
    :forecast_rain,
    :hours_before_rain,
    :hours_after_rain,
    :inspection_event,
    :notice_of_discharge,
    :ph_sample,
    :post_storm_inspection,
    :pre_storm_inspection,
    :quarterly_inspction,
    :reap,
    :report_received,
    :report_sent,
    :turbidity

  def inspection_needed?
    if Time.now.monday?
      start_inspection_event_workflow
      puts 'Inspection event workflow started.'
    else
      puts'No inspection event work flow needed.'
    end
  end

  def start_inspection_event_workflow
    check_inspection_event
    if inspection_event?
=begin
      User.all.each do
        InspectionEvent.create
      end
=end
      puts "Inspection Event prepared"
    end

    check_cem2023
    if cem2023?
      User.all.each do
      InspectionEvent.create
=begin
      # throws type column db error
      Report.create(
          :type => "cem2023",
          :status => "needs attention"
          )
      puts "CEM2023 prepared"
=end
      end
    end

    check_cem2024
    if cem2024?
=begin
      # do not spam users yet
      User.all.each do
        Report.create(
          :type => 'CEM2024',
          :status => "needs attention"
          )
      end
=end
      puts "CEM2024 prepared"
    end
=begin
    # debug no method error
    check_cem2030
    if cem2030?
      User.all.each do
        Report.create(
          :type => 'CEM2030',
          :status => "needs attention"
        )
      end

      puts "CEM2030 prepared"
    end
=end
    check_cem2034
    if cem2034?
=begin
      # do not spam users yet
      User.all.each do
        Report.create(
          :type => 'CEM2034',
          :status => "needs attention"
        )
      end
=end
      puts "CEM2034 prepared"
    end

    check_cem2035
    if cem2035?
=begin
      # do not spam users yet
      User.all.each do
        Report.create(
          :type => 'CEM2035',
          :status => "needs attention"
          )
      end
=end
      puts "CEM2035 prepared"
    end

    check_cem2040
    if cem2040?
=begin
      # do not spam users yet
      User.all.each do
        Report.create(
          :type => 'CEM2040',
          :status => "needs attention"
          )
      end
=end
      puts "CEM2040 prepared"
    end
  end

  def check_inspection_event
    prepare_inspection_event unless self.inspection_event?
  end

  def prepare_inspection_event
    self.inspection_event = true
    "Inspection event prepared"
  end

  def check_cem2023
    prepare_cem2023 unless self.cem2023?
  end

  def prepare_cem2023
    self.cem2023 = true
    "CEM2023 prepared"
  end

  def check_cem2024
    prepare_cem2024 unless self.cem2024?
  end

  def prepare_cem2024
    self.cem2024 = true
    "CEM2024 prepared"
  end

  def check_cem2030
    # cem2030 throws no method error...
    # prepare_cem2030 unless self.cem2030?
  end

  def prepare_cem2030
    self.cem2030 = true
    "CEM2030 prepared"
  end

  def check_cem2034
    prepare_cem2034 unless self.cem2034?
  end

  def prepare_cem2034
    self.cem2034 = true
    "CEM2034 prepared"
  end

  def check_cem2035
    prepare_cem2035 unless self.cem2035?
  end

  def prepare_cem2035
    self.cem2035 = true
    "CEM2035 prepared"
  end

  def check_cem2040
    prepare_cem2040 unless self.cem2040?
  end

  def prepare_cem2040
    self.cem2040 = true
    "CEM2040 prepared"
  end
end
