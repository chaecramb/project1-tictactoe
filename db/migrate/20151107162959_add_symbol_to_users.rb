class AddSymbolToUsers < ActiveRecord::Migration
  def change
    add_column :users, :symbol, :string
  end
end
