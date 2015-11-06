class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.string :symbol, null: false

      t.timestamps null: false
    end
  end
end
