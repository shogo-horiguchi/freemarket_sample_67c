class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.integer :brand_id,null: true
      t.text :text, null: false
      t.string :condition, null: false
      t.string :shipping_charge, null: false
      t.string :shipping_origin, null: false
      t.string :shipping_schedule, null: false
      t.references :user, foreign_key: true
      t.references :saler, foreign_key: { to_table: :users }
      t.references :buyer, foreign_key: { to_table: :users }
      t.references :category, foreign_key: true
      t.timestamps
    end
  end
end
