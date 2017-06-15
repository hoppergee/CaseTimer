class AddTaskTemplatesGroupIdToTaskTemplate < ActiveRecord::Migration[5.0]
  def change
    add_column :task_templates, :task_templates_group_id, :integer
  end
end
