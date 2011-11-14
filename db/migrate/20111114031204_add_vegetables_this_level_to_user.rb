class AddVegetablesThisLevelToUser < ActiveRecord::Migration
  def change
    add_column :users, :vegetablesthislevel, :integer
  end
end
