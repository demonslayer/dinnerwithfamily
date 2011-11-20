class AddAcceptedToBattle < ActiveRecord::Migration
  def change
    add_column :battles, :accepted, :boolean
  end
end
