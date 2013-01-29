class SamplingEvent < ActiveRecord::Base

  scope :needs_attention, where(status: "needs_attention")
  scope :completed, where(status: "completed")

  belongs_to :site

  attr_accessible :analysis_average_1,
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
    :submitted_by

private

  def change_inspection_event_Status
    self.status = "completed"
  end
    
end
