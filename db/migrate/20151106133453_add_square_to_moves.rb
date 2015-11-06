class AddSquareToMoves < ActiveRecord::Migration
  def change
    add_column :moves, :square, :integer
  end
end
