class AddPictureToReward < ActiveRecord::Migration[5.0]
  def change
    add_column :rewards, :image_url, :string
  end
end
