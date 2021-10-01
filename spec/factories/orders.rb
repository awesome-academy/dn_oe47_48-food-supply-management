FactoryBot.define do
  factory :order do
    user_id {create(:user).id}
    status {"processing"}
  end
end
