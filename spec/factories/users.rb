FactoryBot.define do
  factory :user do
    last_name { "テスト" }
    first_name { "1号" }
    profile_text { "テストです" }
    nickname { "test1" }
    email { "teat@test" }
    password { "testtest" }
  end
end
