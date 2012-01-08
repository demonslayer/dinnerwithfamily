class AddVegtypeToUser < ActiveRecord::Migration
  def change
    add_column :users, :vegtype, :string
  end
end
