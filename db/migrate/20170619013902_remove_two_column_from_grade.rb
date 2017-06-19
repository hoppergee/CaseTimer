class RemoveTwoColumnFromGrade < ActiveRecord::Migration[5.0]
  def change
  	remove_column :grades, :task_template_id
  	remove_column :grades, :task_group_id
  end
end
