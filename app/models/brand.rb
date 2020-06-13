class Brand < ActiveHash::Base
  include ActiveHash::Associations
  has_many :items
  self.data = [
    {id: 1, name: 'nike'}, {id: 2, name: 'アディダス'}, {id: 3, name: 'Reebok'},
    {id: 4, name: 'シャネル'}, {id: 5, name: 'エルメス'}, {id: 6, name: 'ルイ・ヴィトン'}
  ]
end
