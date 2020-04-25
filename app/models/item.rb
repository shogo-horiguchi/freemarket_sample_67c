class Item < ApplicationRecord
  belongs_to :user
  belongs_to :brand
  has_many :comments
  has_many :images
  has_many :tags
  has_many :categories, through: :tags
end
