class AddIndexToGroupInCase < ActiveRecord::Migration[5.0]
  def change
  	add_index :cases, :task_tempaltes_group_id
  end
end
