class AddJoulesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :joules, :integer
    add_column :users, :totalbattles, :integer
    add_column :users, :totalvictories, :integer
  end
end
