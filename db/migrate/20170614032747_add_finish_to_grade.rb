class AddFinishToGrade < ActiveRecord::Migration[5.0]
  def change
    add_column :grades, :finish, :boolean
  end
end
