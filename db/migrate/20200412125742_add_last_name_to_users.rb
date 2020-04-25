class AddLastNameToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :last_name, :string, null: false, unique: true
    add_column :users, :first_name, :string, null: false, unique: true
    add_column :users, :last_name_kana, :string, null: false
    add_column :users, :first_name_kana, :string, null: false
    add_column :users, :birth_year, :date, null: false
    add_column :users, :birth_month, :date, null: false
    add_column :users, :birth_day, :date, null: false
  end
end
