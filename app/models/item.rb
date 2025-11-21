class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_one_attached :image
  #has_one :order
  belongs_to :user
  

  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_fee
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_day

  # バリデーション
  validates :image, :name, :description, :category_id, :condition_id, :shipping_fee_id,
            :prefecture_id, :shipping_day_id, :price, presence: true

  validates :category_id, :condition_id, :shipping_fee_id, :prefecture_id, :shipping_day_id,
            numericality: { other_than: 1, message: "を選択してください" }

  validates :price,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 300,
              less_than_or_equal_to: 9_999_999,
              message: "は¥300〜¥9,999,999の間で入力してください"
            }
end
