class InspectionEvent < ActiveRecord::Base

  scope :needs_attention, where(status: "needs_attention")
  scope :completed, where(status: "completed")

  belongs_to :site

  attr_accessible :inspected_by,
    :inspection_date,
    :inspection_description,
    :inspection_type,
    :site_id,
    :submitted_by

private

  def change_inspection_event_Status
    self.status = "completed"
  end

end
