class RemoveCaseTemplateIdFromTaskTemplate < ActiveRecord::Migration[5.0]
  def change
  	remove_column :task_templates, :case_template_id
  end
end
