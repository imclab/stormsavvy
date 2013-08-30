require 'date'
require 'time'

class InspectionEventWorkflow < ActiveRecord::Base

  belongs_to :site
  accepts_nested_attributes_for :site

  # validates :site_id, :presence => true

  attr_accessible :site,
    :site_id,
    :cem2023,
    :cem2024,
    :cem2030,
    :cem2034,
    :cem2035,
    :cem2040,
    :amount_of_rain,
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
      puts 'Workflow started.'
    else
      puts 'Workflow not needed.'
    end
  end

  def start_inspection_event_workflow
    check_inspection_event

    check_cem2023
    if cem2023?
      "CEM2023 prepared"
    end

    check_cem2024
    if cem2024?
      "CEM2024 prepared"
    end

    check_cem2034
    if cem2034?
      "CEM2034 prepared"
    end

    check_cem2035
    if cem2035?
      "CEM2035 prepared"
    end

    check_cem2040
    if cem2040?
      "CEM2040 prepared"
    end
  end

  def check_inspection_event
    prepare_inspection_event unless self.inspection_event?
  end

  def prepare_inspection_event
    InspectionEvent.create(
      :site => @site,
      :site_id => @site.object_id,
      :inspection_date => Date.today,
      :inspection_type => "CEM2030",
      :completed => false
    )

    # place into user loop later
    # User.all.each do
    # end

    self.inspection_event = true
    puts 'Inspection event prepared'

    if inspection_event?
      User.all.each do
        # InspectionEvent.create
        # "Inspection event created"
      end
    end
  end

  def check_cem2023
    prepare_cem2023 unless self.cem2023?
  end

  def prepare_cem2023
    InspectionEvent.create(
      :site => @site,
      :site_id => @site.object_id,
      :inspection_date => Date.today,
      :inspection_type => "CEM2023",
      :completed => false,
      # throws mass-assignment error
      # :cem2023 => true
    )

    # place into user loop later
    # User.all.each do
    # end

    self.cem2023 = true

    if cem2023?
      User.all.each do
        # named scopes railscast: http://goo.gl/bPgj
        # ie = InspectionEvent.needs_attention.build
        # ie.save
        "CEM2023 prepared"
      end
    end

    self.cem2023 = true
    "CEM2023 prepared"
  end

  def check_cem2024
    prepare_cem2024 unless self.cem2024?
  end

  def prepare_cem2024
    InspectionEvent.create(
      :site => @site,
      :site_id => @site.object_id,
      :inspection_date => Date.today,
      :inspection_type => "CEM2024",
      :completed => false
      # throws mass-assignment error
      # :cem2024 => true
    )

    # place into user loop later
    # User.all.each do
    # end

    self.cem2024 = true
    "CEM2024 prepared"
  end

  def check_cem2034
    prepare_cem2034 unless self.cem2034?
  end

  def prepare_cem2034
    InspectionEvent.create(
      :site => @site,
      :site_id => @site.object_id,
      :inspection_date => Date.today,
      :inspection_type => "CEM2034",
      :completed => false
      # throws mass-assignment error
      # :cem2034 => true
    )

    # place into user loop later
    # User.all.each do
    # end

    self.cem2034 = true
    "CEM2034 prepared"
  end

  def check_cem2035
    prepare_cem2035 unless self.cem2035?
  end

  def prepare_cem2035
    InspectionEvent.create(
      :site => @site,
      :site_id => @site.object_id,
      :inspection_date => Date.today,
      :inspection_type => "CEM2035",
      :completed => false
      # throws mass-assignment error
      # :cem2035 => true
    )

    # place into user loop later
    # User.all.each do
    # end

    self.cem2035 = true
    "CEM2035 prepared"
  end

  def check_cem2040
    prepare_cem2040 unless self.cem2040?
  end

  def prepare_cem2040
    InspectionEvent.create(
      :site => @site,
      :site_id => @site.object_id,
      :inspection_date => Date.today,
      :inspection_type => "CEM2040",
      :completed => false
      # throws mass-assignment error
      # :cem2040 => true
    )

    # place into user loop later
    # User.all.each do
    # end

    self.cem2040 = true
    "CEM2040 prepared"
  end
end
