class AddAttachmentToInspectionEvents < ActiveRecord::Migration
  def self.up
    add_attachment :inspection_events, :attachment
  end

  def self.down
    remove_attachment :inspection_events, :attachment
  end
end
