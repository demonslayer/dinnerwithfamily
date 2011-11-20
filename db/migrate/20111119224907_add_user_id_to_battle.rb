class AddUserIdToBattle < ActiveRecord::Migration
  def change
    add_column :battles, :user_id, :integer
  end
end
