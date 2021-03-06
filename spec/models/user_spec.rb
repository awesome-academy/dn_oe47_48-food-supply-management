require "rails_helper"

RSpec.describe User, type: :model do
  let!(:user){FactoryBot.create :user}
  let!(:user2){
    FactoryBot.build :user, full_name: Faker::Name.name,
    email: "FOXPHAN95@gmail.com"
  }
  describe "associations" do
    it "must belong to by town" do
      is_expected.to belong_to :town
    end
    it "has many cart sessions" do
      is_expected.to have_many :cart_sessions
    end
    it "has many orders" do
      is_expected.to have_many :orders
    end
  end

  describe "validates" do
    context "full name" do
      it "when have the presence" do
        is_expected.to validate_presence_of(:full_name).with_message I18n.t("errors.messages.blank")
      end
      it "when valid length" do
        is_expected.to validate_length_of(:full_name).is_at_most(50)
                                                     .with_message I18n.t("errors.messages.too_long", count: 50)
      end
    end

    context "phone" do
      it "when have the presence" do
        is_expected.to validate_presence_of(:phone).with_message I18n.t("errors.messages.blank")
      end
      it "when invalid length - too short" do
        is_expected.to validate_length_of(:phone).is_at_least(10)
                                                 .with_message I18n.t("errors.messages.too_short", count: 10)
      end
      it "when invalid length - too long" do
        is_expected.to validate_length_of(:phone).is_at_most(11)
                                                 .with_message I18n.t("errors.messages.too_long", count: 11)
      end
      it "when invalid format" do
        is_expected.not_to allow_value("aaa1aa2312a").for(:phone)
                                                     .with_message I18n.t("errors.messages.invalid")
      end
    end

    context "email" do
      it "when have the presence" do
        is_expected.to validate_presence_of(:email).with_message I18n.t("errors.messages.blank")
      end
      it "must be uniqueness" do
        is_expected.to validate_uniqueness_of(:email).case_insensitive
                                                     .with_message I18n.t("errors.messages.taken")
      end
      it "when valid format" do
        is_expected.to allow_value("example@gmail.com").for(:email)
      end
      it "when invalid format" do
        is_expected.not_to allow_value("examm...@...").for(:email)
                                                      .with_message I18n.t("errors.messages.invalid")
      end
      it "must downcase before save" do
        user2.save!
        expect(user2.email).to eq "foxphan95@gmail.com"
      end
    end

    context "address" do
      it "when have the presence of street" do
        is_expected.to validate_presence_of(:street).with_message I18n.t("errors.messages.blank")
      end
    end
    
    context "password" do
      it "must have the presence" do
        is_expected.to validate_presence_of(:password).with_message I18n.t("errors.messages.blank")
      end
      it "must valid length" do
        is_expected.to validate_length_of(:password).is_at_least(6)
                                                    .with_message I18n.t("errors.messages.too_short", count: 6)
      end
    end
  end
end
