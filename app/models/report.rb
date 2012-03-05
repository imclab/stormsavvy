class Report < ActiveRecord::Base
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
  :wdid_number

  #before_save :link_report_to_project
  before_update :change_report_status

private

  def change_report_status
    self.status = "complete"
  end

  def link_report_to_project
    @project = self.site.project
    self.project_id = @project.id
  end

end
