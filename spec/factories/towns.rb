FactoryBot.define do
  factory :town do
    name {Faker::Address.city}
    district_id {create(:district).id}
  end
end
