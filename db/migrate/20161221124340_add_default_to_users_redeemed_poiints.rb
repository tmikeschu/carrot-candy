class AddDefaultToUsersRedeemedPoiints < ActiveRecord::Migration[5.0]
  def change
    change_column_default :users, :redeemed_points, 0
  end
end
