class CreateTaskTemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :task_templates do |t|
      t.string :user_id
      t.string :integer
      t.string :case_template_id
      t.string :integer
      t.string :title
      t.string :string

      t.timestamps
    end
  end
end
