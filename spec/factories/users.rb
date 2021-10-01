FactoryBot.define do
  factory :user do
    full_name {"Faker::Name.name"}
    email {Faker::Internet.email.downcase}
    phone {Faker::Number.number(digits: 10)}
    street {Faker::Address.street_address}
    password {"123123123"}
    password_confirmation {"123123123"}
    role {"admin"}
    town_id {create(:town).id}
  end
end
