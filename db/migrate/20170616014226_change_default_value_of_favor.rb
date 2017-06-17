class ChangeDefaultValueOfFavor < ActiveRecord::Migration[5.0]
  def change
  	change_column_default :favors, :goal, 3
  end
end
