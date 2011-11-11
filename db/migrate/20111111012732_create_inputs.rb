class CreateInputs < ActiveRecord::Migration
  def change
    create_table :inputs do |t|
      t.integer :vegetables
      t.integer :user_id

      t.timestamps
    end
  end
end
