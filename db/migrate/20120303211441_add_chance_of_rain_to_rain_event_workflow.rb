class AddChanceOfRainToRainEventWorkflow < ActiveRecord::Migration
  def change
    add_column :rain_event_workflows, :chance_of_rain, :integer

  end
end
