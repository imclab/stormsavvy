class RainEventWorkflow < ActiveRecord::Base

  # We'll make this send a message to the user in the future.
  def check_reap
    "Prepare REAP" unless self.reap?
  end

  # We'll make this send a message to the user in the future.
  # Yes, there is metaprogramming "opportunity" here...
  def check_cem2030
    "Prepare CEM2030" unless self.cem2030?
  end
end
