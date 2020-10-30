FactoryBot.define do
  factory :post do
    association :user
    association :sake_brewery
    sake_name { 'テスト酒' }
    sake_text { 'テストです' }
    sake_degree { 1 }
  end
end
