FactoryBot.define do
  factory :order_destination do
    postal_code { Faker::Number.number(digits: 7).to_s.insert(3, "-") }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    city { Faker::Address.city }
    addresses { Faker::Address.street_address }
    building { Faker::Lorem.characters(number: 10) }
    phone_number { Faker::Number.number(digits: 11).to_s }
    token { "tok_abcdefghijk00000000000000000000" }
  end
end
