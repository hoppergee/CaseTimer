class CreateFavors < ActiveRecord::Migration[5.0]
  def change
    create_table :favors do |t|
      t.integer :user_id
      t.integer :case_id
      t.integer :goal
      t.integer :task_templates_group_id
      t.timestamps
    end
  end
end
