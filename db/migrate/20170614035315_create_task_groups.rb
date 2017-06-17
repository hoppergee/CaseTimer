class CreateTaskGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :task_groups do |t|
      t.integer :case_id
      t.integer :user_id

      t.timestamps
    end
  end
end
