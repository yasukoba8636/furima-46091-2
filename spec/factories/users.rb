FactoryBot.define do
  factory :user do
    nickname { "testuser" }
    email { Faker::Internet.unique.email }
    password { "password1" } # 英字+数字
    password_confirmation { password }
    last_name { "山田" }
    first_name { "太郎" }
    last_name_read { "ヤマダ" }
    first_name_read { "タロウ" }
    birthday { "1990-01-01" }
  end
end

