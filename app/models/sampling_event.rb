class SamplingEvent < ActiveRecord::Base

  scope :needs_attention, -> {  where(status: "needs_attention") }
  scope :completed, -> { where(status: "completed") }

  belongs_to :site
  accepts_nested_attributes_for :site

  validates :site_id, :presence => true

  attr_accessible :site,
    :site_id,
    :analysis_average_1,
    :analysis_average_2,
    :analysis_average_3,
    :analysis_average_4,
    :analysis_average_5,
    :analysis_result_1,
    :analysis_result_2,
    :analysis_result_3,
    :analysis_result_4,
    :analysis_result_5,
    :analysis_type_1,
    :analysis_type_2,
    :analysis_type_3,
    :analysis_type_4,
    :analysis_type_5,
    :sample_id_1,
    :sample_id_2,
    :sample_id_3,
    :sample_id_4,
    :sample_id_5,
    :sample_location_1,
    :sample_location_2,
    :sample_location_3,
    :sample_location_4,
    :sample_location_5,
    :sample_time_1,
    :sample_time_2,
    :sample_time_3,
    :sample_time_4,
    :sample_time_5,
    :sampled_by,
    :sampling_date,
    :sampling_description,
    :sampling_type,
    :site_id,
    :submitted_by,
    :status,
    :completed,
    :attachment # s3 uploads via paperclip

    has_attached_file :attachment,
      url: "http://stormsavvy.s3-website-us-east-1.amazonaws.com",
      storage: :s3,
      bucket: 'stormsavvy'
      # validates_attachment :attachment, presence: true, size: { less_than: 10.megabytes }

    TYPES = [
      'Daily Monitoring', 'Creek Diversion Monitoring','Rain Event Sampling' 'Notice of Discharge'
    ]

private

  def change_inspection_event_status
    self.status = "completed"
  end

end
