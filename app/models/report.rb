class Report < ActiveRecord::Base

  scope :needs_attention, -> { where(:status => "needs_attention") }
  scope :completed, -> { where(:status => "completed") }

  belongs_to :site
  accepts_nested_attributes_for :site

  validates :site_id, :presence => true

  attr_accessible :site,
    :site_id,
    :needs_attention,
    :completed,
    :type,
    :status,
    :inspection_type,
    :attachment # s3 uploads via paperclip

  has_attached_file :attachment,
    url: "http://stormsavvy.s3-website-us-east-1.amazonaws.com",
    storage: :s3,
    bucket: 'stormsavvy'
  # validates_attachment :attachment, presence: true, size: { less_than: 10.megabytes }

private

  def change_report_status
    self.status = "completed"
  end

end
