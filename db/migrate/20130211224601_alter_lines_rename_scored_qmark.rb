class AlterLinesRenameScoredQmark < ActiveRecord::Migration
  def up
    rename_column :lines, :scored?, :scored
    add_column :lines, :active, :boolean, :default => true
  end

  def down
    rename_column :lines, :scored, :scored?
    remove_column :lines, :active
  end
end
