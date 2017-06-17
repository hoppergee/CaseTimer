class DropCaseTemplate < ActiveRecord::Migration[5.0]
  def change
  	drop_table :case_templates
  end
end
