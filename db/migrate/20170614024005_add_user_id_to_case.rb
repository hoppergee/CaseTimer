class AddUserIdToCase < ActiveRecord::Migration[5.0]
  def change
    add_column :cases, :user_id, :integer
  end
end
