class AddColumnsToHomes < ActiveRecord::Migration[5.0]
  def change
    add_column :payments, :customer_id, :string, null: false
    add_column :payments, :card_id, :string, null: false
  end
end
