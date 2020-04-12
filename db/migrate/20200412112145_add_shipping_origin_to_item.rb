class AddShippingOriginToItem < ActiveRecord::Migration[5.0]
  # 入れ忘れ追記
  def change
    add_column :items, :shipping_origin, :string
  end
end
