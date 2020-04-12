class Item < ApplicationRecord
  belongs_to :user

  # 数字を3桁区切りにするメソッド
  # def jpy_comma
  #   self.to_s.gsub(/(\d)(?=(\d{3})+(?!\d))/, '\1,')
  # end
end
