class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  validates :nickname,presence: true,
                      length: {minimum: 3, maximum: 8}
  validates :last_name,:first_name,:birth_date,presence: true
  validates :last_name_kana,:first_name_kana,presence: true,
                                              format: {
                                                with: /[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+/,
                                                message: "全角カタカナのみで入力してください"
                                              }

  has_many :items
  has_many :comments
  has_one :payment

  has_many :buyed_items, foreign_key: "buyer_id", class_name: "Item"
  has_many :saling_items, -> { where("buyer_id is NULL") }, foreign_key: "saler_id", class_name: "Item"
  has_many :sold_items, -> { where("buyer_id is not NULL") }, foreign_key: "saler_id", class_name: "Item"
  has_one :address
end
