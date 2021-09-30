FactoryBot.define do
  factory :product do
    category_id {create(:category).id}
    name {"Product"}
    price {10.0}
    quantity {100}
    description {Faker::Lorem.characters(number: 60)}
  end
end
