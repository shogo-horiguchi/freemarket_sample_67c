class AddNicknameToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :birth_date, :date
    remove_column :users, :birth_year, :date
    remove_column :users, :birth_month, :date
    remove_column :users, :birth_day, :date
  end
end
