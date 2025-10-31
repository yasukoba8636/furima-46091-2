ER図は以下の構成で作成しています。
各テーブルの関係は次の通りです

User
 ├── has_many :items
 ├── has_many :orders (as buyer)
Item
 ├── belongs_to :user
 ├── belongs_to :category
 └── has_one :order
Order
 ├── belongs_to :buyer (User)
 ├── belongs_to :item
 └── has_one :shipping_address
ShippingAddress
 └── belongs_to :order
Category
 └── has_many :items

 Users テーブル
| Column             | Type   | Options                   | Description   |
| ------------------ | ------ | ------------------------- | ------------- |
| nickname           | string | null: false               | ニックネーム        |
| email              | string | null: false, unique: true | メールアドレス       |
| encrypted_password | string | null: false               | パスワード（Devise） |
| last_name          | string | null: false               | 姓             |
| first_name         | string | null: false               | 名             |
| last_name_read     | string | null: false               | 姓（カナ）         |
| first_name_read    | string | null: false               | 名（カナ）         |
| birthday           | date   | null: false               | 生年月日          |

Association
has_many :items
has_many :orders, foreign_key: :buyer_id

Items テーブル
| Column              | Type       | Options                        | Description           |
| ------------------- | ---------- | ------------------------------ | --------------------- |
| name                | string     | null: false                    | 商品名                   |
| description         | text       | null: false                    | 商品説明                  |
| price               | integer    | null: false                    | 価格                    |
| condition           | integer    | null: false                    | 商品の状態（enum）           |
| shipping_payer      | integer    | null: false                    | 配送料の負担（enum）          |
| shipping_method     | integer    | null: false                    | 配送方法（enum）            |
| shipping_prefecture | integer    | null: false                    | 発送元の地域（enum）          |
| shipping_days       | integer    | null: false                    | 発送までの日数（enum）         |
| status              | integer    | default: 0                     | 出品状態（0: 出品中, 1: 売却済み） |
| user                | references | null: false, foreign_key: true | 出品者                   |
| category            | references | null: false, foreign_key: true | カテゴリ                  |

Association
belongs_to :user
belongs_to :category
has_one :order

Orders テーブル
| Column         | Type       | Options                                        | Description |
| -------------- | ---------- | ---------------------------------------------- | ----------- |
| buyer          | references | null: false, foreign_key: { to_table: :users } | 購入者         |
| item           | references | null: false, foreign_key: true, unique: true   | 購入された商品     |
| total_price    | integer    | null: false                                    | 購入時の金額      |
| payment_status | integer    | default: 0                                     | 支払い状態（enum） |

Association

belongs_to :buyer, class_name: "User"
belongs_to :item
has_one :shipping_address

ShippingAddresses テーブル
| Column       | Type       | Options                                      | Description |
| ------------ | ---------- | -------------------------------------------- | ----------- |
| order        | references | null: false, foreign_key: true, unique: true | 対応する購入情報    |
| postal_code  | string     | null: false                                  | 郵便番号        |
| prefecture   | string     | null: false                                  | 都道府県        |
| city         | string     | null: false                                  | 市区町村        |
| address1     | string     | null: false                                  | 番地          |
| address2     | string     |                                              | 建物名・部屋番号    |
| phone_number | string     | null: false                                  | 電話番号        |

Association
belongs_to :order

Categories テーブル
| Column   | Type   | Options     | Description           |
| -------- | ------ | ----------- | --------------------- |
| name     | string | null: false | カテゴリ名                 |
| ancestry | string |             | 親子階層（ancestry gemを使用） |

Association
has_many :items