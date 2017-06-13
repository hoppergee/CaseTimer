class AddSomeSolumnToCase < ActiveRecord::Migration[5.0]
  def change
  	add_column :cases, :title, :string
  	add_column :cases, :description, :text
  end
end
