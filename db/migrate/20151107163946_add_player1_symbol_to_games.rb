class AddPlayer1SymbolToGames < ActiveRecord::Migration
  def change
    add_column :games, :player1_symbol, :string
  end
end
