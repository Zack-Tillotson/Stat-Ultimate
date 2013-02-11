class AddLinePlayerTable < ActiveRecord::Migration
  def up
    create_table :line_players do |t|
      t.integer :line_id
      t.integer :player_id
    end
    remove_column :lines, :player_id
    add_column :lines, :line_player_id, :integer
  end

  def down
  end
end
