class CreateCaseTemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :case_templates do |t|
    	t.integer :user_id
    	t.string :title
		t.timestamps
    end
  end
end
