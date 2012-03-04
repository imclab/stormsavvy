class Report < ActiveRecord::Base
  belongs_to :site
  attr_accessible :type
  before_save :generate_report


private

  def generate_report

  end

end
