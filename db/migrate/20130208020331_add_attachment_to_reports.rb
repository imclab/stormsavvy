class AddAttachmentToReports < ActiveRecord::Migration
  def self.up
    add_attachment :reports, :attachment
  end

  def self.down
    remove_attachment :reports, :attachment
  end
end
