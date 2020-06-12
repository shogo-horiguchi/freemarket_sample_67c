class Item < ApplicationRecord
  belongs_to :user
  belongs_to :brand, optional: true
  accepts_nested_attributes_for :brand
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :brand
  has_many :comments, dependent: :destroy
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  belongs_to :category, optional: true
  accepts_nested_attributes_for :category
  belongs_to :saler, class_name: "User", optional: true,foreign_key: "saler_id"
  belongs_to :buyer, class_name: "User", optional: true,foreign_key: "buyer_id"

  validates :images, presence: {message: 'を投稿してください'}
  validates :name, presence: {message: 'を入力してください'}
  validates :text, presence: {message: 'について何か語ってくださいな'}
  validates :category_id, presence: {message: 'を選択してください'}
  validates :size, presence: {message: 'を選択してください'}
  validates :condition, presence: {message: 'を選択してください'}
  validates :shipping_origin, {presence: true}
  validates :shipping_charge, {presence: true}
  validates :shipping_schedule, {presence: true}
  validates :price, presence: {message: 'を設定しない？嘘でしょ'}
  validates :price, numericality: { greater_than_or_equal_to: 300, message: 'は300円以上から設定できます'}, unless: :nil_price
  validates :price, numericality: { less_than_or_equal_to: 9999999, message: 'は9999999円以下で設定してください'}, unless: :nil_price
  def nil_price
    price == nil
  end
end


