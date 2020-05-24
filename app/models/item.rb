class Item < ApplicationRecord
  belongs_to :user
  belongs_to :brand, optional: true
  accepts_nested_attributes_for :brand
  has_many :comments, dependent: :destroy
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  belongs_to :category
  accepts_nested_attributes_for :category
  belongs_to :saler, class_name: "User", optional: true,foreign_key: "saler_id"
  belongs_to :buyer, class_name: "User", optional: true,foreign_key: "buyer_id"

  validates :name, {presence: true}
  validates :price, {presence: true}
  validates :text, {presence: true}
  validates :category_id, {presence: true}
  validates :condition, {presence: true}
  validates :shipping_charge, {presence: true}
  validates :shipping_origin, {presence: true}
  validates :shipping_schedule, {presence: true}

end


