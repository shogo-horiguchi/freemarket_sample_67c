# README

# Database construction

## users_table
|Column|Type|Options|
|------|----|-------|
|user_nickname|string|index: true, null: false, unique: true|
|user_email|string|null: false, unique: true|
|user_password|string|null: false|
|user_last_name|string|null: false|
|user_first_name|string|null: false|
|user_last_name_kana|string|null: false|
|user_first_name_kana|string|null: false|
|user_birth_year|date|null: false|
|user_birth_month|date|null: false|
|user_birth_day|date|null: false|
### users_association
- has_many :items
- has_many :comments
- has_one :payment
- has_one :addressee

## addresses_table
|Column|Type|Options|
|------|----|-------|
|addressee_last_name|string|null: false|
|addressee_first_name|string|null: false|
|addressee_last_name_kana|string|null: false|
|addressee_first_name_kana|string|null: false|
|addressee_postal_code|integer|null: false|
|addressee_prefecture|string|null: false|
|addressee_city|string|null: false|
|addressee_street|string|null: false|
|addressee_building|string|
|addressee_telephone|integer|unique: true|
|user_id|references|null: false, foreign_key: true|
### addressees_association
- belongs_to :user

## items_table
|Column|Type|Options|
|------|----|-------|
|item_name|string|null: false|
|item_price|integer|null: false|
|item_text|text|null: false|
|item_condition|string|null: false|
|item_shipping_charge|string|null: false|
|item_shipping_origin|string|null: false|
|item_shipping_schedule|string|null: false|
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
|category_name|string|null: false|
### categories_association
- has_many :tags
- has_many :items, through: :tags

## comments_table
|Column|Type|Options|
|------|----|-------|
|comments_text|text|null: false|
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|
### comments_association
- belongs_to :user
- belongs_to :item

## payments_table
|Column|Type|Options|
|------|----|-------|
|payment_card_number|integer|null: false, unique: true|
|payment_expiration_year|integer|null: false|
|payment_expiration_month|integer|null: false|
|payment_security_key|integer|null: false|
|user_id|references|null: false, foreign_key: true|
### payments_association
- belongs_to :user

## brands_table
|Column|Type|Options|
|------|----|-------|
|brand_name|string|null: false, unique: true|
### brands_association
- has_many :items

## images_table
|Column|Type|Options|
|------|----|-------|
|image_url|string|null: false|
|item_id|references|null: false, foreign_key: true|
### images_association
- belongs_to :item
