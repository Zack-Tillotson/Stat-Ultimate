class AlterGamesTeamIdNotNull < ActiveRecord::Migration
  def up
    change_column :games, :team_id, :integer, :null => false
  end

  def down
    change_column :games, :team_id, :integer, :null => true
  end
end
