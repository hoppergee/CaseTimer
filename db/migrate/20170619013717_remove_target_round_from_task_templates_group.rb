class RemoveTargetRoundFromTaskTemplatesGroup < ActiveRecord::Migration[5.0]
  def change
  	remove_column :task_templates_groups, :target_round
  end
end
