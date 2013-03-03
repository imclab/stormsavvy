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
    if Time.now.sunday?
      start_inspection_event_workflow
    end
  end

  def start_inspection_event_workflow
    check_inspection_event
    if inspection_event?
      "Inspection Event prepared"
      InspectionEvent.create
    end

    check_cem2023
    if cem2023?
      "CEM2023 prepared"
      Report.create(:type => 'CEM2023')
    end

    check_cem2024
    if cem2024?
      "CEM2024 prepared"
      Report.create(:type => 'CEM2024')
    end

    check_cem2030
    if cem2030?
      "CEM2030 prepared"
      Report.create(:type => 'CEM2030')
    end

    check_cem2034
    if cem2034?
      "CEM2034 prepared"
      Report.create(:type => 'CEM2034')
    end

    check_cem2035
    if cem2035?
      "CEM2035 prepared"
      Report.create(:type => 'CEM2035')
    end

    check_cem2040
    if cem2040?
      "CEM2040 prepared"
      Report.create(:type => 'CEM2040')
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
    prepare_cem2030 unless self.cem2030?
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

  def check_cem2040
    prepare_cem2040 unless self.cem2040?
  end

  def prepare_cem2040
    self.cem2040 = true
    "CEM2040 prepared"
  end

end
