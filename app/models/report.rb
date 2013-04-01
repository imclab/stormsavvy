class Report < ActiveRecord::Base

  scope :needs_attention, where(:status => "needs_attention")
  scope :completed, where(:status => "completed")

  belongs_to :site

  attr_accessible :needs_attention,
    :completed,
    :type,
    :site_information_name,
    :site_address_1,
    :site_address_2,
    :site_city,
    :site_state,
    :site_zipcode,

    :contractor_name,
    :contractor_address_1,
    :contractor_address_2,
    :contractor_city,
    :contractor_state,
    :contractor_zipcode,

    :contract_number,
    :project_identifier_number,
    :wdid_number,
    :status,

    :submitted_by_contractor,
    :submitted_by_date,

    :wpc_manager,
    :wpc_phone,
    :wpc_emergency_phone,

    :inspector_name,
    :inspection_date,

    :weather_condition,
    # clear / partly cloudy / cloudy

    :precipitation_condition,
    # misty/ light_rain / rain / heavy_rain / hail / snow

    :wind_condition,
    # none / less_5mph / more_5mph

    :construction_phase,
    # highway_construction / plant_establishment /
    # suspension_of_work

    :total_area,
    :total_DSA,
    :current_DSA,
    :inactive_DSA,

    :inspection_type,
    # weekly / quarterly / pre_storm / during_storm /
    # post-storm

    :time_elapsed_last_storm,
    # x_days

    :precipitation_received,
    # x_inches

    :time_storm_expected,
    # x_time, x_date

    :expected_precipitation_amount,
    # x_inches

    :gauge_reading_during_storm,
    # x_inches

    :time_elapsed_post_storm,
    # x_hours_minutes

    :gauge_reading_post_storm,
    # x_inches

    :attachment # s3 uploads via paperclip

  has_attached_file :attachment,
    :url => "http://stormsavvy.s3-website-us-east-1.amazonaws.com",
    :storage => :s3,
    :bucket => 'stormsavvy'
  # validates_attachment :attachment, presence: true, size: { less_than: 10.megabytes }

private

  def change_report_status
    self.status = "completed"
  end

end
