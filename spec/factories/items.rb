# spec/factories/items.rb
FactoryBot.define do
  factory :item do
    name              { "テスト商品" }
    description       { "テスト用の商品説明" }
    category_id       { 2 }  # 1は未選択の「---」用の場合が多い
    condition_id      { 2 }
    shipping_fee_id   { 2 }
    prefecture_id     { 2 }
    shipping_day_id   { 2 }
    price             { 1000 }

    # associationでユーザーと紐付け
    association :user

    # ダミー画像を添付
    after(:build) do |item|
      item.image.attach(
        io: StringIO.new("dummy image content"),  # 文字列でダミー画像
        filename: "test_image.png",
        content_type: "image/png"
      )
    end
  end
end
