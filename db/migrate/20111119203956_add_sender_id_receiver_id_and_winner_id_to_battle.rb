class AddSenderIdReceiverIdAndWinnerIdToBattle < ActiveRecord::Migration
  def change
    add_column :battles, :sender_id, :integer
    add_column :battles, :receiver_id, :integer
    add_column :battles, :winner_id, :integer
  end
end
