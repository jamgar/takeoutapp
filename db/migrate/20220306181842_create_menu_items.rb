class CreateMenuItems < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_items do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.boolean :available
      t.belongs_to :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
