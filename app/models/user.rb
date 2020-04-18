class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
  validates :nickname,presence: true,
                      length: {minimum: 3, maximum: 8}
  validates :last_name,:first_name,:last_name_kana,:first_name_kana,:birth_date,presence: true
  has_one :address
end
