class AddPriceToInventoryItem < ActiveRecord::Migration
  
  def change
    add_column :inventory_items, :price, :integer
  end
  
end
