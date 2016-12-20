class AddPointsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :points, :integer
    add_column :users, :redeemed_points, :integer
  end
end
