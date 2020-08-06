class Address < ApplicationRecord

  belongs_to :user, optional: true
  validates :last_name, :first_name, :postal_code, :prefecture, :city, :street, presence: true
  validates :last_name_kana, :first_name_kana, presence: true,
                                                format: {
                                                  with: /[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+/,
                                                  message: "全角カタカナのみで入力してください"
                                                }
  validates :postal_code, presence: true,
                          format: {
                            with: /\A\d{7}\z/,
                            message: "ハイフンなしで入力してください"
                          }
  validates :telephone, presence: true,
                        format: {
                          with: /\A\d{10}\z|\A\d{11}\z/ ,
                          message: "ハイフンなしで入力してください"
                        }
end

