class AddOpponentToGame < ActiveRecord::Migration
  def change
    add_column :games, :opponent, :string
  end
end
