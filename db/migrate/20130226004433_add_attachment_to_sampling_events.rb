class AddAttachmentToSamplingEvents < ActiveRecord::Migration
  def self.up
    add_attachment :sampling_events, :attachment
  end

  def self.down
    remove_attachment :sampling_events, :attachment
  end
end
