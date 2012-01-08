class AddEquippedItemToUser < ActiveRecord::Migration
  def change
    add_column :users, :equippeditem, :string
  end
end
