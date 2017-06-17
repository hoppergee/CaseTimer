class UpdateColumsOfTaskTemplate < ActiveRecord::Migration[5.0]
  def change
  	remove_column :task_templates, :user_id
  	remove_column :task_templates, :integer
  	remove_column :task_templates, :title
  	remove_column :task_templates, :string
  	add_column :task_templates, :use_id, :integer
  	add_column :task_templates, :title, :string
  	add_column :task_templates, :description, :text
  end
end
