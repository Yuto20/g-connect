class CreateDirectMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :direct_messages do |t|

      t.string :content,  null: false
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.timestamps
    end
  end
end
