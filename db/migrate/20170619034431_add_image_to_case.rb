class AddImageToCase < ActiveRecord::Migration[5.0]
  def change
    add_column :cases, :image, :string
  end
end
