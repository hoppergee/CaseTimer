class AddIndexToGroupInCase < ActiveRecord::Migration[5.0]
  def change
  	add_index :task_templates_groups, :case_id
  end
end
