class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :apple_id
      t.string :trade_no
      t.timestamps
    end
  end
end
