class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i.freeze
  VALID_PHONE_REGEX = /\d[0-9]\)*\z/.freeze

  enum role: {admin: 0, suppiler: 1, buyer: 3}

  belongs_to :town
  has_many :cart_sessions, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :full_name, presence: true,
    length: {maximum: Settings.length.max_name}
  validates :email, presence: true,
    length: {maximum: Settings.length.max_email},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :phone, presence: true,
    length: {
      minimum: Settings.length.min_phone,
      maximum: Settings.length.max_phone
    },
    format: {with: VALID_PHONE_REGEX}
  validates :password, presence: true,
    length: {minimum: Settings.length.min_password}
  has_secure_password

  before_save{email.downcase!}
end
