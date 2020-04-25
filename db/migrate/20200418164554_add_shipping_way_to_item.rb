class AddShippingWayToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :shipping_way, :string
  end
end
