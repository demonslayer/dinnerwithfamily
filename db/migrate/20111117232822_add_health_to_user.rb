class AddHealthToUser < ActiveRecord::Migration
  def change
	add_column :users, :health, :integer
  end
end
