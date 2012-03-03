class RainEventWorkflow < ActiveRecord::Base

  # We'll make this send a message to the user in the future.
  def check_reap
    "Prepare REAP" unless self.reap?
  end
end
