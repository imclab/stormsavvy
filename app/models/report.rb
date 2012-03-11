class Report < ActiveRecord::Base

  scope :needs_attention, where(status: "needs_attention")
  scope :completed, where(status: "complete")

  belongs_to :site

  attr_accessible :type,
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
  :contactor_state,
  :contactor_zipcode,

  :contract_number,
  :project_identifer_number,
  :wdid_number,
  :status

  before_update :change_report_status

private

  def change_report_status
    self.status = "complete"
  end

end
