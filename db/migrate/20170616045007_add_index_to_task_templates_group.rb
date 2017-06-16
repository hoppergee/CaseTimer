class AddIndexToTaskTemplatesGroup < ActiveRecord::Migration[5.0]
  def change
  	add_index :task_templates_groups, :task_template_id
  end
end
