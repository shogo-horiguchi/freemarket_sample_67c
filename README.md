# README

# Database construction

## users_table
|Column|Type|Options|
|------|----|-------|
|nickname|string|index: true, null: false, unique: true|
|email|string|null: false, unique: true|
|password|string|null: false|
|last_name|string|null: false|
|first_name|string|null: false|
|last_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birth_date|date|null: false|
### users_association
- has_many :items
- has_many :comments
- has_one :payment
- has_one :address

## addresses_table
|Column|Type|Options|
|------|----|-------|
|last_name|string|null: false|
|first_name|string|null: false|
|last_name_kana|string|null: false|
|first_name_kana|string|null: false|
|postal_code|integer|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|street|string|null: false|
|building|string|
|telephone|integer|
|user_id|references|null: false, foreign_key: true|
### addresses_association
- belongs_to :user

## items_table
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|price|integer|null: false|
|text|text|null: false|
|condition|string|null: false|
|shipping_charge|string|null: false|
|shipping_origin|string|null: false|
|shipping_schedule|string|null: false|
|user_id|references|null: false, foreign_key: true|
|brand_id|references|null: false, foreign_key: true|
### items_association
- belongs_to :user
- belongs_to :brand
- has_many :comments
- has_many :images
- has_many :categories, through: :tags

## tags_table
|Column|Type|Options|
|------|----|-------|
|item_id|references|null: false, foreign_key: true|
|category_id|references|null: false, foreign_key: true|
### tags_association
- belongs_to :item
- belongs_to :category

## categories_table
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|

### categories_association
- has_many :tags
- has_many :items, through: :tags

## comments_table
|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|item_id|references|null: false, foreign_key: true|
|user_id|references|null: false, foreign_key: true|
### comments_association
- belongs_to :user
- belongs_to :item

## payments_table
|Column|Type|Options|
|------|----|-------|
|card_id|string|null: false|
|customer_id|string|null: false|
|user_id|references|null: false, foreign_key: true|
### payments_association
- belongs_to :user

## brands_table
|Column|Type|Options|
|------|----|-------|
|name|string|unique: true|
### brands_association
- has_many :items

## images_table
|Column|Type|Options|
|------|----|-------|
|url|string|null: false|
|item_id|references|null: false, foreign_key: true|
### images_association
- belongs_to :item


