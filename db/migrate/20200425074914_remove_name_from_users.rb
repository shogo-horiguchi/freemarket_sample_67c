class RemoveNameFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :birth_year, :date
    remove_column :users, :birth_month, :date
    remove_column :users, :birth_day, :date
    add_column :users, :birth_date, :date
  end
end
