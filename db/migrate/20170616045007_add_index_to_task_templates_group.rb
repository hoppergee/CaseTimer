class AddIndexToTaskTemplatesGroup < ActiveRecord::Migration[5.0]
  def change
  	add_index :task_templates, :task_templates_group_id
  end
end
