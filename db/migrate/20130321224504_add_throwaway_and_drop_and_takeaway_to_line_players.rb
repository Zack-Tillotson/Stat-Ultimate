class AddThrowawayAndDropAndTakeawayToLinePlayers < ActiveRecord::Migration
  def change
    add_column :line_players, :throwaway, :integer, :default => 0
    add_column :line_players, :drop, :integer, :default => 0
    add_column :line_players, :takeaway, :integer, :default => 0
  end
end
