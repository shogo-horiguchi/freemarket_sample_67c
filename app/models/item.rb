class Item < ApplicationRecord
  belongs_to :user
  belongs_to :brand, optional: true
  accepts_nested_attributes_for :brand
  has_many :comments
  has_many :images
  accepts_nested_attributes_for :images, allow_destroy:true
  belongs_to :category, optional: true
  accepts_nested_attributes_for :category

  validates :name, {presence: true}
  validates :price, {presence: true}
  validates :text, {presence: true}
  validates :condition, {presence: true}
  validates :shipping_charge, {presence: true}
  validates :shipping_origin, {presence: true}
  validates :shipping_schedule, {presence: true}

end


