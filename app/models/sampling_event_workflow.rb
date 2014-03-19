class SamplingEventWorkflow < ActiveRecord::Base

  belongs_to :site
  accepts_nested_attributes_for :site

  # attr_accessible :title, :body
  attr_accessible :site,
    :cem2051,
    :cem2052,
    :hours_before_rain,
    :ph_sample,
    :turbidity,
    :report_sent,
    :report_received,
    :chance_of_rain,
    :amount_of_rain,
    :forecast_rain,
    :sampling_event

  def sampling_imminent?
    if chance_of_rain > 50 && forecast_rain > 0.5 && hours_before_rain < 24
      start_sampling_event_workflow
    end
  end

  def start_sampling_event_workflow
    check_sampling_event
    if sampling_event?
      "Sampling event prepared"
    end

    check_cem2051
    if cem2051?
      "CEM2051 prepared"
    end

    check_cem2052
    if cem2052?
      "CEM2052 prepared"
    end
  end

  # Needs logic for updating rain status
  def has_rained?
    amount_of_rain > 0.5
  end

  def check_cem2051
    prepare_cem2051 unless self.cem2051?
  end

  def prepare_cem2051
    SamplingEvent.create(
      sampling_date: Date.today,
      completed: false
    )
    # SamplingEvent.create(
    #   sampling_date: Date.today,
    #   status: "needs_attention"
    # )

    self.cem2051 = true
    "CEM2051 prepared"
  end

  def check_cem2052
    prepare_cem2052 unless self.cem2052?
  end

  def prepare_cem2052
    SamplingEvent.create(
      sampling_date: Date.today
    )

    self.cem2052 = true
    "CEM2052 prepared"
  end

  def check_sampling_event
    prepare_sampling_event unless self.sampling_event?
  end

  def prepare_sampling_event
    SamplingEvent.create(
      :sampling_date => Date.today
    )

    self.sampling_event = true
    "Sampling Event prepared"
  end
end
