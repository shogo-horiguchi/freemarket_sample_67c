class Category < ApplicationRecord
  has_many :tags
  has_many :items, through: :tags
end
