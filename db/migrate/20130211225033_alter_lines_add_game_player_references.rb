class AlterLinesAddGamePlayerReferences < ActiveRecord::Migration
  def up
    add_column :lines, :game_id, :integer
    add_column :lines, :player_id, :integer
  end

  def down
    remove_column :lines, :game_id
    remove_column :lines, :player_id
  end
end
