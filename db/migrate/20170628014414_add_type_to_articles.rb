class AddTypeToArticles < ActiveRecord::Migration[5.0]
  def change
  	add_column :articles, :category, :string, :default => "tech"
  end
end
