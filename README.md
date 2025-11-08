ER図は以下の構成で作成しています。
各テーブルの関係は次の通りです

User
 ├── has_many :items
 └── has_many :orders

Item
 ├── belongs_to :user
 └── has_one :order

Order
 ├── belongs_to :user
 ├── belongs_to :item
 └── has_one :shipping_address

ShippingAddress
 └── belongs_to :order

## Users テーブル
| Column             | Type   | Options                   | Description   |
| ------------------ | ------ | ------------------------- | ------------- |
| nickname           | string | null: false               | ニックネーム        |
| email              | string | null: false, unique: true | メールアドレス       |
| encrypted_password | string | null: false               | パスワード（Devise） |
| last_name          | string | null: false               | 姓             |
| first_name         | string | null: false               | 名             |
| last_name_kana     | string | null: false               | 姓（カナ）         |
| first_name_kana    | string | null: false               | 名（カナ）         |
| birthday           | date   | null: false               | 生年月日          |

**Association**
- has_many :items
- has_many :orders, foreign_key: :user_id, dependent: :destroy

## Items テーブル
| Column                 | Type       | Options                        | Description         |
| ---------------------- | ---------- | ------------------------------ | ------------------- |
| name                   | string     | null: false                    | 商品名                 |
| description            | text       | null: false                    | 商品説明                |
| price                  | integer    | null: false                    | 価格                  |
| condition_id           | integer    | null: false                    | 商品の状態（ActiveHash）   |
| shipping_method_id     | integer    | null: false                    | 配送方法（ActiveHash）    |
| shipping_prefecture_id | integer    | null: false                    | 発送元の地域（ActiveHash）  |
| shipping_days_id       | integer    | null: false                    | 発送までの日数（ActiveHash） |
| category_id            | integer    | null: false                    | カテゴリ（ActiveHash）    |
| user                   | references | null: false, foreign_key: true | 出品者（ユーザー）           |

**Association**
- belongs_to :user
- has_one :order, dependent: :destroy
- belongs_to_active_hash :condition
- belongs_to_active_hash :shipping_method
- belongs_to_active_hash :shipping_prefecture
- belongs_to_active_hash :shipping_days
- belongs_to_active_hash :category

## Orders テーブル
| Column | Type       | Options                        | Description |
| ------ | ---------- | ------------------------------ | ----------- |
| user   | references | null: false, foreign_key: true | 購入者（ユーザー）   |
| item   | references | null: false, foreign_key: true | 購入された商品     |

**Association**
- belongs_to :user
- belongs_to :item
- has_one :shipping_address, dependent: :destroy

## ShippingAddresses テーブル
| Column         | Type       | Options                        | Description      |
| -------------- | ---------- | ------------------------------ | ---------------- |
| order          | references | null: false, foreign_key: true | 購入情報             |
| postal_code    | string     | null: false                    | 郵便番号             |
| prefecture_id  | integer    | null: false                    | 都道府県（ActiveHash） |
| city           | string     | null: false                    | 市区町村             |
| street_address | string     | null: false                    | 番地               |
| building_name  | string     |                                | 建物名・部屋番号         |
| phone_number   | string     | null: false                    | 電話番号             |

**Association**
- belongs_to :order
- belongs_to_active_hash :prefecture
