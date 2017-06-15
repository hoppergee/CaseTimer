class CreateGrades < ActiveRecord::Migration[5.0]
  def change
    create_table :grades do |t|
      t.integer :user_id
      t.integer :case_id
      t.integer :task_template_id
      t.integer :round_time
      t.integer :round

      t.timestamps
    end
  end
end
