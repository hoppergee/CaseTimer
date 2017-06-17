class AddTaskTemplatesGroupIdToGrade < ActiveRecord::Migration[5.0]
  def change
    add_column :grades, :task_templates_group_id, :integer
  end
end
