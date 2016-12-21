class CreateRewards < ActiveRecord::Migration[5.0]
  def change
    create_table :rewards do |t|
      t.string :name
      t.integer :quantity
      t.integer :point_value

      t.timestamps
    end
  end
end
