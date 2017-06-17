class AddTaskGroupIdToTask < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :task_group_id, :integer
  end
end
