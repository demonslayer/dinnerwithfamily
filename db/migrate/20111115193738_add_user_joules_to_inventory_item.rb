class AddUserJoulesToInventoryItem < ActiveRecord::Migration
  def change
    add_column :inventory_items, :userjoules, :integer
  end
end
