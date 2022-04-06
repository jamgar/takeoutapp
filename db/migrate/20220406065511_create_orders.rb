class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :customer
      t.string :confirmation
      t.decimal :total
      t.boolean :fullfilled, default: false # <- add default: false

      t.timestamps
    end
  end
end
