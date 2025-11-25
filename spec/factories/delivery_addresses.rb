FactoryBot.define do
  factory :delivery_address do
    order { nil }
    postal_code { "MyString" }
    prefecture_id { 1 }
    municipality { "MyString" }
    address { "MyString" }
    building { "MyString" }
    phone { "MyString" }
  end
end
