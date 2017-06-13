class AddSomeColumnToTask < ActiveRecord::Migration[5.0]
  def change
  	add_column :tasks, :title, :string
  	add_column :tasks, :description, :text
  	add_column :tasks, :user_id, :integer
  	add_column :tasks, :case_id, :integer
  	add_column :tasks, :practice_time, :integer
  	add_column :tasks, :round, :integer
  end
end
