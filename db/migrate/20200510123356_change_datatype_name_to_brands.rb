class ChangeDatatypeNameToBrands < ActiveRecord::Migration[5.0]
  def change
    change_column :brands, :name, :string, null: true, unique: true
  end
end
