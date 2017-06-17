class AddCaseIdToTaskTemplate < ActiveRecord::Migration[5.0]
  def change
  	add_column :task_templates, :case_id, :integer
  end
end
