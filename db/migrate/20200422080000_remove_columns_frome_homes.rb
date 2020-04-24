class RemoveColumnsFromeHomes < ActiveRecord::Migration[5.0]
  def change
    remove_column :payments, :card_number, null: false, unique: true
    remove_column :payments, :expireation_year, null: false
    remove_column :payments, :expiration_month, null: false
    remove_column :payments, :security_key, null: false
  end
end
