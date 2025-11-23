class Order < ApplicationRecord
  belongs_to :item
  belongs_to :user   # 購入者
  has_one :address   # 配送先住所
end
