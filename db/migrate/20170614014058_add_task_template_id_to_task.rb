class AddTaskTemplateIdToTask < ActiveRecord::Migration[5.0]
  def change
  	add_column :tasks, :task_template_id, :integer
  	remove_column :tasks, :case_id
  end
end
