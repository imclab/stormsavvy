class InspectionEvent < ActiveRecord::Base

  # no status attribute for named scope
  # scope :needs_attention, where(status: "needs_attention")
  # scope :completed, where(status: "completed")

  scope :needs_attention, where(:inspection_type => "needs_attention")
  scope :completed, where(:inspection_type => "completed")

  belongs_to :site

  attr_accessible :inspected_by,
    :inspection_date,
    :inspection_description,
    :inspection_type,
    :site_id,
    :submitted_by,
    :attachment # s3 uploads via paperclip

  has_attached_file :attachment,
    :url => "http://stormsavvy.s3-website-us-east-1.amazonaws.com",
    :storage => :s3,
    :bucket => 'stormsavvy'
  # validates_attachment :attachment, presence: true, size: { less_than: 10.megabytes }

private

  def change_inspection_event_status
    self.status = "completed"
  end

end
