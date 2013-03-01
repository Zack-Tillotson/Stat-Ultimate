class AddReceiverColumnToLines < ActiveRecord::Migration
  def change
    add_column :lines, :received, :boolean
  end
end
