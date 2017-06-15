class UpdateAColumnNameOfTaskTemplate < ActiveRecord::Migration[5.0]
  def change
  	rename_column :task_templates, :use_id, :user_id
  end
end
