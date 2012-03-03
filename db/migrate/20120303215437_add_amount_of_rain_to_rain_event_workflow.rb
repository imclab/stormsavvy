class AddAmountOfRainToRainEventWorkflow < ActiveRecord::Migration
  def change
    add_column :rain_event_workflows, :amount_of_rain, :float

  end
end
