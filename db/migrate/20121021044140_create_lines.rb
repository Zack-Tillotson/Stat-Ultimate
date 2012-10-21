class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.boolean :scored?

      t.timestamps
    end
  end
end
