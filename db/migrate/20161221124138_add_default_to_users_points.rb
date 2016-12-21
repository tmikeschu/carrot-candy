class AddDefaultToUsersPoints < ActiveRecord::Migration[5.0]
  def change
    change_column_default :users, :points, 0
  end
end
