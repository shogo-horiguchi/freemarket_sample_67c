class ChangeDatatypeBrandIdOfItems < ActiveRecord::Migration[5.0]
  def change
    change_column :items, :brand_id, :integer, null: true
  end
end
