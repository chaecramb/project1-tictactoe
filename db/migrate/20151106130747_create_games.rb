class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :board, array: true, default: [nil, nil, nil, nil, nil, nil, nil, nil, nil]
      t.integer :player1_id
      t.integer :player2_id
      t.integer :current_player_id
      t.integer :winner_id
      t.boolean :is_draw

      t.timestamps null: false
    end
  end
end
