# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#brandsテーブル
Brand.create(name: 'シャネル')
Brand.create(name:'nike')
Brand.create(name:'ディーゼル')

#categoryテーブル
Category.create(name: '本・書籍')
Category.create(name: '服・衣類')
Category.create(name: '電子機器')
Category.create(name: 'アクセサリー')