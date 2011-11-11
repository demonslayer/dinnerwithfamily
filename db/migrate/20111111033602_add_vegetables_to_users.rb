class AddVegetablesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :vegetables, :integer
  end
end
