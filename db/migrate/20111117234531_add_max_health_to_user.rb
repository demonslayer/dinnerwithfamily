class AddMaxHealthToUser < ActiveRecord::Migration
  def change
    add_column :users, :maxhealth, :integer
  end
end
