class CreateBattles < ActiveRecord::Migration
  def change
    create_table :battles do |t|

      t.timestamps
    end
  end
end
