class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.text :text, null: false
      t.string :condition, null: false
      t.string :shipping_charge, null: false
      t.string :shipping_origin, null: false
      t.string :shipping_schedule, null: false
      t.references :user, foreign_key: true, null: false
      t.references :brand, foreign_key: true, null: false
      t.timestamps
    end
  end
end
