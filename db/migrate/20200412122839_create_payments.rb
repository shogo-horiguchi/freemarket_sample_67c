class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.integer :card_number, null: false, unique: true
      t.integer :expireation_year, null: false
      t.integer :expiration_month, null: false
      t.integer :security_key, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
