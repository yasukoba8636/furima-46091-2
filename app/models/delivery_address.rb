class DeliveryAddress < ApplicationRecord
  belongs_to :order

  # バリデーション（要件に合わせる）
  validates :postal_code, presence: true, format: { with: /\A\d{3}-\d{4}\z/, message: "は「123-4567」形式で入力してください" }
  validates :prefecture_id, presence: true, numericality: { other_than: 0 }  # ActiveHashなら別処理
  validates :municipality, presence: true
  validates :address, presence: true
  validates :phone, presence: true, format: { with: /\A\d{10,11}\z/, message: "はハイフンなしの半角10〜11桁で入力してください" }
end

