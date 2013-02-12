class WrongNamesOnIds < ActiveRecord::Migration
  def up
    remove_column :lines, :line_player_id, :integer
  end

  def down
  end
end
