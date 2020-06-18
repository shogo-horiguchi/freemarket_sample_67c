class RemoveShippingWayFromItems < ActiveRecord::Migration[5.0]
  def change
    remove_column :items, :shipping_way, :string
  end
end
