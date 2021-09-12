class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :platform, null: false
      t.string :ancestry
      t.timestamps
    end
    add_index :games, :ancestry
  end
end
