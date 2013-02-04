class FixIdentiferTypo < ActiveRecord::Migration
  def change
  	# Fixing typos in AddFieldsToReport migration file
	  # Comment out remove_column - fails heroku migration
  	# remove_column :reports, :project_identifer_number, :string
  	add_column :reports, :project_identifier_number,   :string
  end
end
