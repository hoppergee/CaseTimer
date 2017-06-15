class AddTargetRoundToTaskTemplatesGroup < ActiveRecord::Migration[5.0]
  def change
    add_column :task_templates_groups, :target_round, :integer
  end
end
