class DropTaskGroup < ActiveRecord::Migration[5.0]
  def change
  	drop_table :task_groups
  end
end
