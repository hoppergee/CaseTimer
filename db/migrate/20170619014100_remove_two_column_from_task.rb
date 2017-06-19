class RemoveTwoColumnFromTask < ActiveRecord::Migration[5.0]
  def change
  	remove_column :tasks, :user_id
  	remove_column :tasks, :task_group_id
  end
end
