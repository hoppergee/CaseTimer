class RemoveTwoColumnFromTaskTempalte < ActiveRecord::Migration[5.0]
  def change
  	remove_column :task_templates, :user_id
  	remove_column :task_templates, :case_id
  end
end
