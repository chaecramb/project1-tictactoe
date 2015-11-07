class AddPlayer2SymbolToGames < ActiveRecord::Migration
  def change
    add_column :games, :player2_symbol, :string
  end
end
