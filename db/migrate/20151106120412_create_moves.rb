class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.string :value
      t.integer :player_id
      t.integer :game_id

      t.timestamps null: false
    end
  end
end
