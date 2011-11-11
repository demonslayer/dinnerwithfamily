class CreateInventoryItems < ActiveRecord::Migration
  def change
    create_table :inventory_items do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end
  end
end
