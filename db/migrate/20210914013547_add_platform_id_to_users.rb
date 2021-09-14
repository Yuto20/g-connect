class AddPlatformIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :platform_id, :integer, null: false
    add_column :users, :favorite_id, :integer, null: false
  end
end
