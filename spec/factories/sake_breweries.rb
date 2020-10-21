FactoryBot.define do
  factory :sake_brewery do
  	association :post
    brewery_name { "テスト酒造" }
    brewery_prefecture { "北海道" }
    brewery_address { "札幌市" }
  end
end
